//
//  MovieList.swift
//  Movie-App
//
//  Created by ebpearls on 6/5/24.
//

import Foundation

struct MovieListResult: Codable {
    var page: Int
    var totalPages: Int
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
    var originalTitle: String
    var posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
    }
}