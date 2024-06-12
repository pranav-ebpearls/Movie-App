//
//  MovieData.swift
//  Movie-App
//
//  Created by ebpearls on 6/5/24.
//

import UIKit

enum NetworkError: Error {
    case invalidResponse
    case badURL
    case decodingError
}

extension URL {
    static var getPopularMovies: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/popular"
        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        guard let url = components.url else {
            fatalError("Invalid URL components")
        }
        return url
    }
    
    static var getNowShowingMovies: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/now_playing"
        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        guard let url = components.url else {
            fatalError("Invalid URL components")
        }
        return url
    }
    
    static func getMovieDetails(movieId: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(movieId)"
        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        guard let url = components.url else {
            fatalError("Invalid URL components")
        }
        return url
    }
        
    static func getCastDetails(movieId: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(movieId)/credits"
        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US")
        ]
        guard let url = components.url else {
            fatalError("Invalid URL components")
        }
        return url
    }
    
    static var getAccountDetails: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/account/21308155"

        guard let url = components.url else {
            fatalError("Invalid URL components")
        }
        return url
    }    
}

enum HttpMethod {
    case get ([URLQueryItem])
    case post (Data?)
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HttpMethod = .get([])
}

extension Movie {
    static var popular: Resource<MovieListResult> {
        return Resource(url: URL.getPopularMovies)
    }
    
    static var nowShowing: Resource<MovieListResult> {
        return Resource(url: URL.getNowShowingMovies)
    }
}

extension Language {
    static func movieDetailById(id: Int) -> Resource<MovieDetail> {
        guard let url = URL.getMovieDetails(movieId: id) else {
            fatalError("Error in ID.")
        }
        return Resource(url: url)
    }
}

extension Cast {
    static func getCastById(idNum: Int) -> Resource<CastList> {
        guard let url = URL.getCastDetails(movieId: idNum) else {
            fatalError("Error in ID")
        }
        return Resource(url: url)
    }
}

extension ImgPath {
    static var account: Resource<AccountDatas> {
        return Resource(url: URL.getAccountDetails)
    }
}

class MovieData {
    
    // swiftlint:disable:next line_length
    let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0Yzg0Y2Y2ZTgxOGY3ZDNjMDlmZDFhYWUwOGU2NjQ0YSIsInN1YiI6IjY2NWVmMWFiMGI3MDJhYWM1M2NjYmQxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2K7gDTHZve0s_vsqo1GsoaUaefoo5X_FqJtGQmZ7-mI"
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
        case .post(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw NetworkError.badURL
            }
            request = URLRequest(url: url)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let (data, response) = try await session.data(for: request)
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
