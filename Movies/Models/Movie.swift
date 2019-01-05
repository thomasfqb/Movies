//
//  Movie.swift
//  Movies
//
//  Created by Thomas Fauquemberg on 04/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import Foundation
import UIKit

struct Movie: ProduceMovieCellViewModel, ProduceMovieDetailsViewModel {

    let title: String
    let popularity: Float
    let posterPath: String
    let releaseDate: String
    let overview: String
    let voteAverage: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["original_title"] as? String ?? ""
        popularity = dictionary["popularity"] as? Float ?? 0.0
        posterPath = dictionary["poster_path"] as? String ?? ""
        releaseDate = dictionary["release_date"] as? String ?? ""
        overview = dictionary["overview"] as? String ?? "No description for this movie..."
        voteAverage = dictionary["vote_average"] as? String ?? "NA"
    }
    
    func toMovieCellViewModel() -> MovieCellViewModel {
        let posterUrlString = "https://image.tmdb.org/t/p/w300\(posterPath)"
        let attributedString = NSMutableAttributedString(string: title,
                                                         attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .bold)])
        attributedString.append(NSAttributedString(string: "\n\(overview)",
            attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                         .foregroundColor: UIColor.gray]))
        
        let movieCellViewModel = MovieCellViewModel(posterUrlString: posterUrlString, attributedText: attributedString)
        return movieCellViewModel
    }
    
    
    func toMovieDetailsViewModel() -> MovieDetailsViewModel {
        let posterUrlString = "https://image.tmdb.org/t/p/w300\(posterPath)"
        let titleAttributedString = NSAttributedString(string: title,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 52, weight: .heavy),
                                                                    .foregroundColor: UIColor.white])
        let overviewAttributedString = NSAttributedString(string: overview,
                                                          attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .bold),
                                                                       .foregroundColor: UIColor.lightGray])
        
        let releaseDateString = "📅 " + releaseDate.components(separatedBy: "-")[0]
        let voteAverageString = "💯 " + voteAverage
        
        let movieCellViewModel = MovieDetailsViewModel(title: titleAttributedString, overview: overviewAttributedString, posterUrlString: posterUrlString, releaseDate: releaseDateString, voteAverage: voteAverageString)
        return movieCellViewModel
    }
}
