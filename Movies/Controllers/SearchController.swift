//
//  searchController.swift
//  Movies
//
//  Created by Thomas Fauquemberg on 12/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let cellId = "cellId"
    fileprivate var currentSearch = ""
    fileprivate var movies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.movies.isEmpty ? (self.informationLabel.isHidden = false) : (self.informationLabel.isHidden = true)
            }
        }
    }
    fileprivate var nextPage = 1
    
    fileprivate let informationLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.lightGray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Looking for a movie ? \nLet's find it ! "
        return lbl
    }()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.placeholder = "title, actor..."
        sb.showsCancelButton = true
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        
        setupLayout()
        setupSearchBar()
       // setupTapToDismiss()
        setupCollectionView()
        search(string: currentSearch)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    fileprivate func setupCollectionView() {
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    fileprivate func setupLayout() {
        view.addSubview(informationLabel)
        informationLabel.centerInSuperview()
    }
    
    // MARK:- SearchBar
    
    fileprivate func setupSearchBar() {
        let navBar = navigationController?.navigationBar
        navBar?.addSubview(searchBar)
        searchBar.anchor(top: navBar?.topItem?.titleView?.bottomAnchor, leading: navBar?.leadingAnchor, bottom: navBar?.bottomAnchor, trailing: navBar?.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12), size: .init(width: 0, height: 20))
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        nextPage = 1
        movies.removeAll()
        currentSearch = searchBar.text ?? ""
        handleDismiss()
        search(string: currentSearch)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentSearch = ""
        searchBar.text = ""
        nextPage = 1
        movies.removeAll()
        collectionView.reloadData()
        handleDismiss()
        search(string: currentSearch)
    }

    // MARK:- Keyboard Management
    
    fileprivate func setupTapToDismiss() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    @objc fileprivate func handleDismiss() {
        self.searchBar.endEditing(true)
    }
    
    
    // MARK:- CollectionViewData
    
    
    fileprivate func search(string: String) {
        MovieService.shared().search(for: string, page: nextPage) { (movies, nextPage, error) in
            if let error = error {
                print("Failed to fetch upcoming Movies" + error.localizedDescription)
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
            search(string: currentSearch)
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

