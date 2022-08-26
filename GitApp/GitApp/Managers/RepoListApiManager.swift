//
//  RepoListApiManager.swift
//  GitApp
//
//  Created by BrainX 3096 on 22/08/2022.
//

import Alamofire
import Foundation
import ObjectMapper

typealias RepoApiResult = Result<[GitRepository], APIError>

class RepoListApiManager {
     func loadRepositories(withCompletion completion: @escaping (RepoApiResult) -> Void) {
        APIManager.shared.performRequest(RepoListRequest.fetchRequest) { result in
            switch result {
            case let .success(value):
                guard let gitRepositoryResult = Mapper<GitRepository>().mapArray(JSONObject: value) else {
                    completion(.failure(APIError(message: CustomStrings.errorOccured)))
                    return
                }
                let repos = gitRepositoryResult.map{ r -> GitRepository in
                    var repo = r
                    repo.language = Languages.language.randomElement()
                    return repo
                }
                dump(repos)
                completion(.success(repos))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
enum RepoListRequest:HTTPRequest {
    case fetchRequest
    var endPoint: URL? {
        switch self {
        case .fetchRequest:
            return URL(string: EndPoints.repoUrlString)
        }
    }
    var method: HTTPMethod {
        switch self {
        case .fetchRequest:
            return .get
        }
    }
}
