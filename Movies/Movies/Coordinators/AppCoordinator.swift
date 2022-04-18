//
//  AppCoordinator.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationBackButtonImage()
    }
    // Navigation: new back button's Image setup
    func navigationBackButtonImage() {
        self.navigationController.navigationBar.backIndicatorImage = UIImage(systemName: Constants.systemBackArrowImageName)
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: Constants.systemBackArrowImageName)
    }

    func start() {
        let vc = MovieViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func movieDetail(_ id: Int) {
        let vc = MovieDetailViewController(with: MovieDetailViewModel(MovieId: id))
        navigationController.pushViewController(vc, animated: true)
    }
}
