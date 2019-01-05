//
//  MovieService.swift
//  Movies
//
//  Created by Thomas Fauquemberg on 10/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit
import SDWebImage

enum MovieCategory: String {
    case trending    = "/popular"
    case topRated   = "/top_rated"
    case upcoming = "/now_playing"
}

class MovieService {
    
    let apiKey = "6bf06b7a537c129fe359973f4cdc31f5"
    let apiPath = "https://api.themoviedb.org/3"
   
    private static var sharedMovieService: MovieService = MovieService()
    
    class func shared() -> MovieService {
        return sharedMovieService
    }
    
    func fetchMovies(for category: MovieCategory, page: Int, completionHandler: @escaping (_ movies: [Movie]?, _ nextPage: Int?, _ error: Error?) -> ()) {
        
        let urlString = "\(apiPath)/movie\(category.rawValue)?api_key=\(apiKey)&page=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, nil, error)
            }
            
            guard let data = data else { return }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] else { return }
            
            // Defining if their is more pages to fetch
            var nextPage: Int?
            if let currentPage = jsonData["page"] as? Int, let totalPages = jsonData["total_pages"] as? Int, currentPage != totalPages {
                nextPage = currentPage + 1
            }
            
            // Creating movies from results
            guard let results = jsonData["results"] as? [[String: Any]] else { return }
            let movies = results.map({ (movieJson) -> Movie in
                return Movie(dictionary: movieJson)
            })
            
            completionHandler(movies, nextPage, nil)
            
        }.resume()
    }
    
    func search(for string: String, page: Int, completionHandler: @escaping (_ movies: [Movie]?, _ nextPage: Int?, _ error: Error?) -> ()) {
        
        let urlString = "\(apiPath)/search/movie?api_key=\(apiKey)&language=en-US&query=\(string)&page=\(page)&include_adult=false"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, nil, error)
            }
            
            guard let data = data else { return }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] else { return }
            
            // Defining if their is more pages to fetch
            var nextPage: Int?
            if let currentPage = jsonData["page"] as? Int, let totalPages = jsonData["total_pages"] as? Int, currentPage != totalPages {
                nextPage = currentPage + 1
            }
            
            // Creating movies from results
            guard let results = jsonData["results"] as? [[String: Any]] else { return }
            let movies = results.map({ (movieJson) -> Movie in
                return Movie(dictionary: movieJson)
            })
            
            completionHandler(movies, nextPage, nil)
            
            }.resume()
    }
    
}
