//
//  MovieViewModel.swift
//  Movies
//
//  Created by Thomas Fauquemberg on 04/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import Foundation

protocol ProduceMovieCellViewModel {
    func toMovieCellViewModel() -> MovieCellViewModel
}


struct MovieCellViewModel {
    
    let posterUrlString: String
    let attributedText: NSAttributedString
    
}
