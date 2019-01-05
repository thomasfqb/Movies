//
//  MovieCell.swift
//  Movies
//
//  Created by Thomas Fauquemberg on 04/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    var movieCellViewModel: MovieCellViewModel? {
        didSet {
            guard let movieCellViewModel = movieCellViewModel else { return }
            infoLabel.attributedText = movieCellViewModel.attributedText
            let posterUrl = URL(string: movieCellViewModel.posterUrlString)
            posterView.sd_setImage(with: posterUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"), options: .continueInBackground, completed: nil)
        }
    }
    
    let cardViewContainer: UIView = {
       let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        return v
    }()
    
    let posterView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let infoLabel: UITextView = {
       let lbl = UITextView()
        lbl.isScrollEnabled = false
        lbl.isEditable = false
        lbl.isSelectable = false
        lbl.isUserInteractionEnabled = false
        return lbl
    }()
    
    let statsStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    fileprivate func setupLayout() {
        addSubview(cardViewContainer)
        cardViewContainer.addShadow()
        cardViewContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 4, left: 10, bottom: 10, right: 10))
        
        cardViewContainer.addSubview(posterView)
        posterView.anchor(top: cardViewContainer.topAnchor, leading: cardViewContainer.leadingAnchor, bottom: cardViewContainer.bottomAnchor, trailing: nil, padding: .init(top: 8, left: 8, bottom: 8, right: 0), size: .init(width: 110, height: 0))
        
        cardViewContainer.addSubview(infoLabel)
        infoLabel.anchor(top: cardViewContainer.topAnchor, leading: posterView.trailingAnchor, bottom: cardViewContainer.bottomAnchor, trailing: cardViewContainer.trailingAnchor, padding: .init(top: 0, left: 6, bottom: 8, right: 8))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
