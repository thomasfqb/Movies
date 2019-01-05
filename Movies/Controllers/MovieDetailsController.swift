//
//  MovieDetailsController.swift
//  Movies
//
//  Created by Thomas Fauquemberg on 11/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class MovieDetailsController: UIViewController, UIScrollViewDelegate {
    
    var movieViewModel: MovieDetailsViewModel? {
        didSet {
            guard let movieViewModel = movieViewModel else { return }
            let posterUrl = URL(string: movieViewModel.posterUrlString)
            posterImageView.sd_setImage(with: posterUrl, completed: nil)
            
            titleLabel.attributedText = movieViewModel.title
            overviewTextView.attributedText = movieViewModel.overview
            statsStackView.addArrangedSubview(createStatLabel(text: movieViewModel.releaseDate, backgroundColor: .lightGray))
            statsStackView.addArrangedSubview(createStatLabel(text: movieViewModel.voteAverage, backgroundColor: .lightGray))
        }
    }
    
    fileprivate func createStatLabel(text: String, backgroundColor: UIColor) -> UILabel {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.backgroundColor = backgroundColor
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 15
        lbl.clipsToBounds = true
        lbl.text = text
        return lbl
    }
    
    fileprivate lazy var contentView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .black
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
    }()
    
    fileprivate let posterImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate let titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
    }()
    
    fileprivate let statsStackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 20
        return sv
    }()
    
    fileprivate let overviewTextView: UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        tv.sizeToFit()
        tv.backgroundColor = .clear
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupGradientLayer()
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = posterImageView.bounds
    }
    
    //MARK:- UI
    
    fileprivate func setupLayout() {
        view.addSubview(contentView)
        contentView.fillSuperview()
        contentView.contentSize = .init(width: view.frame.width, height: 1000)
        
        contentView.addSubview(posterImageView)
        let posterHeight = view.frame.width * 1.5
        posterImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, size: .init(width: view.frame.width, height: posterHeight))
        
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: nil, leading: contentView.leadingAnchor, bottom: posterImageView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 8, right: 8))
        
        contentView.addSubview(statsStackView)
        statsStackView.anchor(top: posterImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 300, height: 30))
        statsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(overviewTextView)
        overviewTextView.anchor(top: statsStackView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 12))
    }
    
    fileprivate var gradientLayer = CAGradientLayer()
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 0.9, 1]
        posterImageView.layer.addSublayer(gradientLayer)
        posterImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 1.5)
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        //Make the navigation bar transparent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
}
