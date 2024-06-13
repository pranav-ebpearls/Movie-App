//
//  MovieList.swift
//  Movie-App
//
//  Created by ebpearls on 6/5/24.
//

import Foundation

struct MovieListResult: Codable {
    var page: Int
    var totalPages: Int?
    var totalResults: Int
    var results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}

struct Movie: Codable {
    var id: Int
    var title: String
    var posterPath: String
    var voteAverage: Double
    var genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
    }
}
