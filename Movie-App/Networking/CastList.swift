//
//  CastList.swift
//  Movie-App
//
//  Created by ebpearls on 6/10/24.
//

import Foundation

struct CastList: Codable {
    var cast: [Cast]
}

struct Cast: Codable {
    var name: String
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case profilePath = "profile_path"
        case name
    }
}
