//
//  AccountData.swift
//  Movie-App
//
//  Created by ebpearls on 6/7/24.
//

import Foundation

struct AccountDatas: Codable {
    var name: String
    var username: String
    var avatar: Avatar?
}

struct Avatar: Codable {
    var tmdb: ImgPath
}

struct ImgPath: Codable {
    var avatarPath: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}
