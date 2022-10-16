//
//  DiscoverModel.swift
//  learnMVP
//
//  Created by User on 13/10/2022.
//

import Foundation

// MARK: - Discover
struct Discover: Decodable {
    let page: Int
    let results: [Movie]
    let totalResults, totalPages: Int
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case page, results
    }
}

// MARK: - Movie
struct Movie: Decodable {
    let posterPath: String
    let adult: Bool
    let overview, releaseDate: String
//    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
//    let originalLanguage: OriginalLanguage
    let title: String
    let popularity: Double
//    let voteCount: Int
//    let video: Bool
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity, adult
        case posterPath = "poster_path"
        case releaseDate = "release_date"
//        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
//        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
    }
}
