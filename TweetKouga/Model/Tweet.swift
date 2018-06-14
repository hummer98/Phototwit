//
//  Tweet.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import Foundation
import ObjectMapper

internal protocol APIResponse {}

extension APIResponse {
    func twitterDateFormatTransform() -> CustomDateFormatTransform {
        return CustomDateFormatTransform(formatString: "eee MMM dd HH:mm:ss ZZZZ yyyy")
    }
}

struct Entities {
    var urls = [String]()
    var hashtags = [String]()
    var user_mentions = [String]()
}


struct Tweet: APIResponse {
    
    var coordinates = ""
    var truncated = false
    var created_at = Date()
    var favorited = false
    var id_str = ""
    var in_reply_to_user_id_str = ""
    var entities = Entities()
    var text = ""
    var contributors = ""
    var retweet_count = 0
    var in_reply_to_status_id_str = ""
    var geo = ""
    var retweeted = false
    var in_reply_to_user_id = ""
    var place = ""
    var source = ""
    
    var user = User()
    
    var in_reply_to_screen_name = ""
    var in_reply_to_status_id = ""
}

extension Tweet: Mappable {
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        coordinates <- map["coordinates"]
        truncated <- map["truncated"]
        created_at <- (map["created_at"], twitterDateFormatTransform())
        favorited <- map["favorited"]
        id_str <- map["id_str"]
        text <- map["text"]
        retweet_count <- map["retweet_count"]
        retweeted <- map["retweeted"]
        in_reply_to_user_id <- map["in_reply_to_user_id"]
        place <- map["place"]
    }
}
