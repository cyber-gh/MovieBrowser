//
// Created by soltan on 14/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

protocol Coordinable {
    var coordinator: Coordinator? { get set }
}