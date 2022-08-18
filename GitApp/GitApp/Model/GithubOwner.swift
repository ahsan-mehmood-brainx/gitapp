//
//  GithubOwner.swift
//  GitApp
//
//  Created by BrainX 3096 on 18/08/2022.
//

import Foundation
import ObjectMapper

struct GithubOwner: Mappable {
    var avatorUrl: String?
    var id: Int?
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        avatorUrl <- map["avatar_url"]
        id <- map["id"]
    }
}
