//
//  MovieDetail.swift
//  Movie-App
//
//  Created by ebpearls on 6/7/24.
//

import Foundation


struct MovieDetail: Codable {
    
    var overview: String
    var posterPath: String
    var title: String
    var runtime: Int
    var spokenLanguages: [Language]
    
    enum CodingKeys: String, CodingKey {
        case overview, title, runtime
        case posterPath = "poster_path"
        case spokenLanguages = "spoken_languages"
    }
}

struct Language: Codable {
    var englishName: String
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
    }
}
