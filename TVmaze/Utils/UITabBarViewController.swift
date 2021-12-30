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
        let homeViewController = HomeViewPresenter()
        HomeConfigurator.injectDependencies(presenter: homeViewController)
        let tabOneViewController = UINavigationController(rootViewController: homeViewController)

        let tabOneBarItem = UITabBarItem(title: "HomeTabBarTitle".localized(),
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))

        tabOneViewController.tabBarItem = tabOneBarItem
        
        let favoritesViewController = FavoritesViewPresenter()
        FavoritesConfigurator.injectDependencies(presenter: favoritesViewController)
        let tabTwoViewController = UINavigationController(rootViewController: favoritesViewController)

        let tabTwoBarItem = UITabBarItem(title: "FavoritesTabBarTitle".localized(),
                                         image: UIImage(systemName: "star"),
                                         selectedImage: UIImage(systemName: "star.fill"))
        
        tabTwoViewController.tabBarItem = tabTwoBarItem
        
        let peopleSearchViewController = PeopleSearchViewPresenter()
        PeopleSearchConfigurator.injectDependencies(presenter: peopleSearchViewController)
        let tabThreeViewController = UINavigationController(rootViewController: peopleSearchViewController)

        let tabThreeBarItem = UITabBarItem(title: "PeopleSearchTabBarTitle".localized(),
                                         image: UIImage(systemName: "person"),
                                         selectedImage: UIImage(systemName: "person.fill"))
        
        tabThreeViewController.tabBarItem = tabThreeBarItem

        self.viewControllers = [tabOneViewController, tabTwoViewController, tabThreeViewController]
    }
}

extension UITabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let homeNavigationController = viewControllers?[0] as? UINavigationController,
              let homeViewController = homeNavigationController.viewControllers[0] as? HomeViewPresenter,
              let favoritesNavigationController = viewControllers?[1] as? UINavigationController,
              let favoritesViewController = favoritesNavigationController.viewControllers[0] as? FavoritesViewPresenter else {
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
