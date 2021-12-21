//
//  UITabBarViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/21/21.
//

import UIKit

class UITabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let homeViewController = HomeViewController()
        HomeConfigurator.injectDependencies(presenter: homeViewController)
        let tabOneViewController = UINavigationController(rootViewController: homeViewController)

        let tabOneBarItem = UITabBarItem(title: "HomeTabBarTitle".localized(),
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        
        tabOneViewController.tabBarItem = tabOneBarItem
        
        self.viewControllers = [tabOneViewController]
    }
}

extension UITabBarViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(String(describing: viewController.title))")
    }
}
