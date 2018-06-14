//
//  TimelineManager.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import UIKit
import TwitterKit
import ObjectMapper

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
    
    static var isLoggedIn: Bool {
        return Twitter.sharedInstance().sessionStore.hasLoggedInUsers()
    }
    
    static func getHomeTimeline(userId: String? = Twitter.sharedInstance().sessionStore.session()?.userID, handler: @escaping ([Tweet]) -> Void) {
        let parameters: [AnyHashable: Any]? = [:]
        let client = TWTRAPIClient(userID: userId)
        var clientError: NSError?
        let request = client.urlRequest(withMethod: "GET", url: URL.homeTimeline.endPoint, parameters: parameters, error: &clientError)
        client.sendTwitterRequest(request) { (response, data, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            guard let tweets = Mapper<Tweet>().mapArray(JSONObject: data) else {
                fatalError()
            }
            handler(tweets)
        }
    }
}
