//
//  MainTabBarController.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 22.10.24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupTabBar()
    }
    
    func setupTabBar() {
        let moviesVC = MoviesViewController()
        let moviesNavVC = UINavigationController(rootViewController: moviesVC)
        moviesNavVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movies"), tag: 0)
        
        let tvShowsVC = TVSeriesViewController()
        let tvShowsNavVC = UINavigationController(rootViewController: tvShowsVC)
        tvShowsNavVC.tabBarItem = UITabBarItem(title: "TV Series", image: UIImage(named: "tv-series"), tag: 1)
        
        let searchVC = SearchViewController()
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        searchNavVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 2)
        
        let peopleVC = PeopleViewController()
        let peopleNavVC = UINavigationController(rootViewController: peopleVC)
        peopleNavVC.tabBarItem = UITabBarItem(title: "People", image: UIImage(named: "people"), tag: 3)
        
        viewControllers = [moviesNavVC, tvShowsNavVC, searchNavVC, peopleNavVC]
    }

    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .gray
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        itemAppearance.selected.iconColor = .blue
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]

        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.layer.cornerRadius = 25
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.layer.shadowColor = UIColor.clear.cgColor
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 0
        tabBar.layer.shadowOpacity = 0
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
