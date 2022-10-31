//
//  GithubAPI.swift
//  ThingsflowTest
//
//  Created by Channoori Park on 2022/10/28.
//

import Foundation
import Moya

enum API {
    case getRepository(_ organization: String, _ repository: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com/repos")!
    }
    
    var path: String {
        switch self {
        case .getRepository(let organization, let repository):
            return "/\(organization)/\(repository)/issues"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRepository:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getRepository(_, _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
