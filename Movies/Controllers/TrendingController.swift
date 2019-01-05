//
//  TrendingController.swift
//  Movies
//
//  Created by Thomas Fauquemberg on 04/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class TrendingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate var movies = [Movie]()
    fileprivate var nextPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Trending"
        
        setupCollectionView()
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        
    }
    
    
    fileprivate func setupCollectionView() {
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    // MARK:- CollectionViewData
    
    fileprivate func fetchMovies() {
        MovieService.shared().fetchMovies(for: .trending, page: nextPage) { (movies, nextPage, error) in
            if let error = error {
                print("Failed to fetch trending movies" + error.localizedDescription)
            }
            
            if let nextPage = nextPage {
                self.nextPage = nextPage
            }
            
            if let movies = movies {
                self.movies.append(contentsOf: movies)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
        movieCell.movieCellViewModel = movies[indexPath.row].toMovieCellViewModel()
        return movieCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == movies.count - 1) {
            fetchMovies()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailsController = MovieDetailsController()
        movieDetailsController.movieViewModel = movies[indexPath.row].toMovieDetailsViewModel()
        navigationController?.pushViewController(movieDetailsController, animated: true)
    }
    
    // MARK:- CollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    
}
