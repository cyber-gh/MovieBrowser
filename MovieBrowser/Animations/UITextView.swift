//
// Created by soltan on 06/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    //TODO code duplication, implement a common transition funciton in uiview
    func setTextAnimated(newText : String?, transType : CATransitionType = .push, transSubtype : CATransitionSubtype? = .fromLeft) {
        guard let newText = newText else {return }
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = transType
        animation.subtype = transSubtype
        self.text = newText
        animation.duration = 0.3
        self.layer.add(animation, forKey: nil)
    }
}