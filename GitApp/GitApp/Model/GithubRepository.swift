//
//  GithubRepository.swift
//  GitApp
//
//  Created by BrainX 3096 on 17/08/2022.
//

import Foundation
import ObjectMapper

struct GitApiResponse: Mappable {
    var name: String?
    var fullName: String?
    var id: Int?
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        name <- map["name"]
        fullName <- map["full_name"]
        id <- map["id"]
    }
}


