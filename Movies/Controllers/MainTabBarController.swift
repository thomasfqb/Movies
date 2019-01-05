//
//  ViewController.swift
//  Movies
//
//  Created by Thomas Fauquemberg on 04/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    
    fileprivate func setupViewControllers() {
        let layout = UICollectionViewFlowLayout()
        
        let topRatedController = setupCustomNavigationController(image: #imageLiteral(resourceName: "topRated"), title: "Top rated", rootViewController: TopRatedController(collectionViewLayout: layout))
        let trendingController = setupCustomNavigationController(image: #imageLiteral(resourceName: "trending"), title: "Trending", rootViewController: TrendingController(collectionViewLayout: layout))
        let upComingController = setupCustomNavigationController(image: #imageLiteral(resourceName: "upComing"), title: "Up coming", rootViewController: UpComingController(collectionViewLayout: layout))
        let searchController = setupCustomNavigationController(image: #imageLiteral(resourceName: "search"), title: "Search", rootViewController: SearchController(collectionViewLayout: layout))
        
        viewControllers = [
            topRatedController,
            trendingController,
            upComingController,
            searchController
        ]
        
        guard let tabBarItems = tabBar.items else { return }
        for item in tabBarItems {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    
    fileprivate func setupCustomNavigationController(image: UIImage, title: String, rootViewController: UIViewController = UIViewController()) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.image = image
        navigationController.title = title
        return navigationController
    }

}

