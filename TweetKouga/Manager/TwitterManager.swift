//
//  TimelineManager.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import UIKit
import Alamofire
import TwitterKit
import ObjectMapper
import RxSwift

final class TwitterManager {
    
    static let baseURL = "https://api.twitter.com"
    static let version = "/1.1"

    enum URL {
        case homeTimeline
        var endPoint: String {
            return baseURL + version + path
        }
        var path: String {
            switch self {
            case .homeTimeline:
                return "/statuses/home_timeline.json"
            }
        }
    }
    
    struct ParseError: Error {}
    
    static var isLoggedIn: Bool {
        return Twitter.sharedInstance().sessionStore.hasLoggedInUsers()
    }
    
    static func getHomeTimeline(userId: String? = Twitter.sharedInstance().sessionStore.session()?.userID) -> Single<[Tweet]> {
        return Single<[Tweet]>.create { singleEvent in
            let parameters: [AnyHashable: Any]? = [:]
            let client = TWTRAPIClient(userID: userId)
            var clientError: NSError?
            let request = client.urlRequest(withMethod: "GET", url: URL.homeTimeline.endPoint, parameters: parameters, error: &clientError)
            client.sendTwitterRequest(request) { (response, data, error) in
                if let error = error {
                    singleEvent(.error(error))
                } else {
                    guard let data = data, let JSONString = String(data: data, encoding: .utf8), let tweets = Mapper<Tweet>().mapArray(JSONString: JSONString) else {
                        singleEvent(.error(ParseError()))
                        return
                    }
                    singleEvent(.success(tweets))
                }
            }
            return Disposables.create {}
        }
    }
    
    static func createSingle<T: Mappable>(withEndpoint endpoint: String,
                                   method: HTTPMethod = .get,
                                   parameters: Parameters? = nil,
                                   encoding: ParameterEncoding = JSONEncoding.default) -> Single<T> {
        return Single<T>.create { singleEvent in
            let request = Alamofire.request(endpoint,
                                            method: method,
                                            parameters: parameters,
                                            encoding: encoding)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let entity = Mapper<T>().map(JSONObject: data)!
                        singleEvent(.success(entity))
                    case .failure(let error):
                        singleEvent(.error(error))
                    }
            }
            return Disposables.create { request.cancel() }
        }
    }
}
