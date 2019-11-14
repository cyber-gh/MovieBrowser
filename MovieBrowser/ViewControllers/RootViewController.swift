//
// Created by soltan on 13/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {

    convenience init(with controller: BaseViewController) {
        self.init(rootViewController: controller)
    }
}

