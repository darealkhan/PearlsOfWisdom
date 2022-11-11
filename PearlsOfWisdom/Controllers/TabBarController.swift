//
//  TabBarController.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 11.11.22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    static let shared = TabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

extension TabBarController {
    private func setupViews() {
        tabBar.tintColor = .actionColor
        tabBar.backgroundColor = .backgroundColor
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.6)
        tabBar.isTranslucent = false
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .backgroundColor
        tabBar.standardAppearance = appearance
        
        let homeViewController = NavController(rootViewController: HomeViewController())
        homeViewController.tabBarItem.title = "Home"
        homeViewController.tabBarItem.image = UIImage(named: "tabbar_home")?.resized(to: CGSize(width: 22, height: 22))
        
        let quotesViewController = NavController(rootViewController: QuotesViewController())
        quotesViewController.tabBarItem.title = "Quotes"
        quotesViewController.tabBarItem.image = UIImage(named: "tabbar_book")?.resized(to: CGSize(width: 22, height: 22))
        
        let aboutViewController = NavController(rootViewController: AboutViewController())
        aboutViewController.tabBarItem.title = "About"
        aboutViewController.tabBarItem.image = UIImage(named: "tabbar_info")?.resized(to: CGSize(width: 22, height: 22))

        self.viewControllers = [homeViewController, quotesViewController, aboutViewController]
    }
}
