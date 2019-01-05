//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Thomas Fauquemberg on 11/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

protocol ProduceMovieDetailsViewModel {
    func toMovieDetailsViewModel() -> MovieDetailsViewModel
}

struct MovieDetailsViewModel {
    
    let title: NSAttributedString
    let overview: NSAttributedString
    let posterUrlString: String
    let releaseDate: String
    let voteAverage: String
    
}


