//
// Created by soltan on 06/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func animateTransition(transType : CATransitionType = .push, transSubtype : CATransitionSubtype? = .fromLeft) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = transType
        animation.subtype = transSubtype
        animation.duration = 0.3
        self.layer.add(animation, forKey: nil)
    }
}