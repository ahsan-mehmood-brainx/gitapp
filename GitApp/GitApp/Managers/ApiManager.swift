//
//  ApiManager.swift
//  GitApp
//
//  Created by BrainX 3096 on 22/08/2022.
//

import Foundation
import Alamofire

protocol HTTPRequest {
    var endPoint: URL? { get }
    var method: HTTPMethod { get }
}

typealias APIClientResult = Result<Any, APIError>

class APIManager {
    
    // MARK: Self Instance
    static let shared = APIManager()
    
    // MARK: Initializers
    private init() {}
    
    // MARK: Public Methods
    func performRequest(_ request: HTTPRequest,
                        withCompletion completion: @escaping (APIClientResult) -> Void) {
        guard let url = request.endPoint else {
            completion(.failure(APIError(message: CustomStrings.urlNotFound)))
            return
        }
        AF.request(
            url,
            method: request.method
        ).responseJSON { response in
            switch response.result {
            case let .success(value):
                completion(.success(value))
            case .failure:
                completion(.failure(APIError(message: CustomStrings.errorOccured)))
            }
        }
    }
}

