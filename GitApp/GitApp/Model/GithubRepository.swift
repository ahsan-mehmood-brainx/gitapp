//
//  GithubRepository.swift
//  GitApp
//
//  Created by BrainX 3096 on 17/08/2022.
//

import ObjectMapper

struct GitRepository: Mappable {
    var name: String?
    var fullName: String?
    var id: Int?
    var gitOwner: GithubOwner?
    var language: String?
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        name <- map["name"]
        fullName <- map["full_name"]
        id <- map["id"]
        gitOwner <- map["owner"]
    }
}


