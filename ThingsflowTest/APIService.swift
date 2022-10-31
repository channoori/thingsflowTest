//
//  APIService.swift
//  ThingsflowTest
//
//  Created by Channoori Park on 2022/10/28.
//

import Foundation
import Moya

class APIService {
    static let shared = APIService()
    let provider = MoyaProvider<API>()
    
    func getRepository(_ organization: String, _ repository: String, completion: @escaping((_ repositorys: [Repository]?, _ errorMsg: String?) -> Void)) {
        provider.request(.getRepository(organization, repository)) { result in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let apiResponse = try JSONDecoder().decode([Repository].self, from:data)
                    completion(apiResponse, nil)
                }
                catch {
                    completion(nil, error.localizedDescription)
                }
            case let .failure(error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
