//
//  Tweet.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import Foundation
import ObjectMapper

struct Tweet {
    var id: Int64 = 0
    var text: String = ""
    var imageURLs: [URL] = []
}

extension Tweet: Mappable {
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        id           <- map["id"]
        text         <- map["text"]
    }
}
