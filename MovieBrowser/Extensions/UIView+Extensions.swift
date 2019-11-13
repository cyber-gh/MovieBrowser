//
// Created by soltan on 11/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addOnClickListener(listener: () -> Void) {
        func handleTap(_ sender: UITapGestureRecognizer? = nil) {
            listener()
        }

        let tap = UITapGestureRecognizer(target: self, action: "handleTap")
        self.addGestureRecognizer(tap)

    }
}