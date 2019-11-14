//
// Created by soltan on 14/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MoviesMainPageViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}