//
//  Model.swift
//  ThingsflowTest
//
//  Created by Channoori Park on 2022/10/28.
//

import Foundation

struct Repository: Codable {
    var number: Int?
    var title: String?
    var body: String?
    var user: User
}

struct User: Codable {
    var login: String
    var id: Int
    var avatar_url: String?
}
