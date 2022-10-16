//
//  NetworkService.swift
//  learnMVP
//
//  Created by User on 13/10/2022.
//

import Foundation
import Alamofire

enum APIError: Error {
    case badURL(Int)
    case serverError(Int)
    case decodeError
    
    var description: String {
            switch self {
            case .badURL(let statusCode):
                return "\(statusCode): bad url or request"
            case .serverError(let statusCode):
                return "\(statusCode): it not your fault its the server so chill!"
            case .decodeError:
                return "could not decode the json data"
            }
        }
}

class NetworkService {
    
    func getApi<D: Decodable>(with endpoint: Endpoints, expecting: D.Type, completion: @escaping(Result<D,APIError>) -> Void) {
        AF.request(endpoint.url).response { response in
            guard let statusCode = response.response?.statusCode else { return }
            if statusCode >= 200 && statusCode < 300 {
                guard let data = response.data else { return }
                do {
                    let result = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(result))
                } catch let error {
                    print("decode error:::\(error.localizedDescription)")
                }
            } else if statusCode <= 500 {
                completion(.failure(.serverError(statusCode)))
            } else {
                completion(.failure(.badURL(statusCode)))
            }
        }
    }
    
}
