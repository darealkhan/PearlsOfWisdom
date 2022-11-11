//
//  NavController.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 11.11.22.
//

import Foundation
import UIKit

class NavController: UINavigationController {
    private var fontSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 24
        } else {
            return 18
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.backgroundColor = .backgroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearance.backgroundImage = UIImage()
        navigationBarAppearance.shadowImage = UIImage()
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
