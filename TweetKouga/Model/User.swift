//
//  User.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import UIKit
import ObjectMapper

struct UserEntities {
    var urls = [String]()
    var description = ""
}

struct User: APIResponse {
    var name = ""
    var profile_sidebar_fill_color = UIColor()
    var profile_background_tile = false
    var profile_sidebar_border_color = UIColor()
    var profile_image_url: URL!
    var created_at = Date()
    var location = ""
    var follow_request_sent = false
    var id_str = ""
    var is_translator = false
    var profile_link_color = UIColor()
    var entities = UserEntities()
    
    var default_profile = false
    var url: URL!
    var contributors_enabled = false
    var favourites_count = 0
    var utc_offset = ""
    var profile_image_url_https: URL!
    var listed_count = 0
    var profile_use_background_image = false
    var profile_text_color = UIColor()
    var followers_count = 0
    var lang = ""
    var protected = false
    var geo_enabled = false
    var notifications = false
    var description = ""
    var profile_background_color = UIColor()
    var verified = ""
    var time_zone = ""
    var profile_background_image_url_https: URL!
    var statuses_count = 0
    var profile_background_image_url: URL!
    var default_profile_image = false
    var friends_count = 0
    var following = false
    var show_all_inline_media = false
    var screen_name = ""
}

extension User: Mappable {
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        name <- map["name"]
        screen_name <- map["screen_name"]
        description <- map["description"]
        created_at <- (map["created_at"], twitterDateFormatTransform())
    }
}
