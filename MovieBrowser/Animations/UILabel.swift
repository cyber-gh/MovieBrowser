//
// Created by soltan on 06/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setTextAnimated(newText : String?, transType : CATransitionType = .push, transSubtype : CATransitionSubtype? = .fromLeft) {
        guard let newText = newText else {return }
        animateTransition(transType: transType, transSubtype: transSubtype)
        self.text = newText

    }
}