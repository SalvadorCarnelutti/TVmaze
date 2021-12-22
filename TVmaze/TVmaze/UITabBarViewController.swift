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
        
        let favoritesViewController = FavoritesViewController()
        FavoritesConfigurator.injectDependencies(presenter: favoritesViewController)
        let tabTwoViewController = UINavigationController(rootViewController: favoritesViewController)

        let tabTwoBarItem = UITabBarItem(title: "FavoritesTabBarTitle".localized(),
                                         image: UIImage(systemName: "star"),
                                         selectedImage: UIImage(systemName: "star.fill"))
        
        tabTwoViewController.tabBarItem = tabTwoBarItem

        self.viewControllers = [tabOneViewController, tabTwoViewController]
    }
}

extension UITabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let homeNavigationController = viewControllers?[0] as? UINavigationController,
              let homeViewController = homeNavigationController.viewControllers[0] as? HomeViewController,
              let favoritesNavigationController = viewControllers?[1] as? UINavigationController,
              let favoritesViewController = favoritesNavigationController.viewControllers[0] as? FavoritesViewController else {
                  return
              }
        
        switch selectedIndex {
        case 0:
            homeViewController.interactor.resetSeriesFavoriteStatus()
        default:
            favoritesViewController.interactor.loadFavorites(favoriteSeries: homeViewController.interactor.getFavorites)
        }
    }
}
