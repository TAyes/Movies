//
//  Coordinator.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
       var navigationController: UINavigationController { get set }

       func start()
}

