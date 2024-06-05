//
//  MovieData.swift
//  Movie-App
//
//  Created by ebpearls on 6/5/24.
//

import UIKit

struct AccountData {
    func getAccountDetail() {
        
    }
}

struct MovieData {
    // async await -> new logic
    
    
    func getMovieDetail() {
        
    }
    
    func getNowShowingMovies() {
        
    }
    
    func getPopularMovies(success: @escaping ((MovieListResult) -> Void), failure: @escaping ((Error) -> Void)) {
        let urlStr = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1"
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0Yzg0Y2Y2ZTgxOGY3ZDNjMDlmZDFhYWUwOGU2NjQ0YSIsInN1YiI6IjY2NWVmMWFiMGI3MDJhYWM1M2NjYmQxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2K7gDTHZve0s_vsqo1GsoaUaefoo5X_FqJtGQmZ7-mI"
        
        if let url = URL(string: urlStr) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
            request.timeoutInterval = 60.0
            
            let session = URLSession.shared
            
            
            let task = session.dataTask(with: url) { (data, response, error) in
                /// failure case
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                        return
                    }
                }
                
                /// success case
                if let data = data {
                    do {
                        /// for logging purpose
                        let object = try JSONSerialization.jsonObject(with: data)
                        let prettyPrintedData = try JSONSerialization.data(
                            withJSONObject: object,
                            options: [.prettyPrinted, .sortedKeys]
                        )
                        let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8)!
                        debugPrint(prettyPrintedString)
                        
                        /// decoding the model
                        let decoder = JSONDecoder()
                        
                        let decodedModel = try decoder.decode(MovieListResult.self, from: data)
            
                        DispatchQueue.main.async {
                            success(decodedModel)
                            return
                        }
                    } catch {
                        debugPrint(error)
                        
                        DispatchQueue.main.async {
                            failure(error)
                            return
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
}
