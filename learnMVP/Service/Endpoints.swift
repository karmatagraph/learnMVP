//
//  Endpoints.swift
//  learnMVP
//
//  Created by User on 13/10/2022.
//

import Foundation

struct API {
    static let baseURL = "https://api.themoviedb.org/3/"
}

protocol Endpoint {
    var path: String { get }
    var url: URL { get }
}

enum Endpoints {
    case discover(Int)
    case movie(Int)
}

extension Endpoints {
    
    var path: String {
        switch self {
        case .discover(let ofPage):
            return "\(API.baseURL)discover/movie?api_key=\(APIKEY.key)&page=\(ofPage)"
        case .movie(let id):
            return "\(API.baseURL)movie/\(id)?api_key=\(APIKEY.key)"
        }
    }
    
    var url: URL {
        return URL(string: "\(path)")!
    }
    
}
