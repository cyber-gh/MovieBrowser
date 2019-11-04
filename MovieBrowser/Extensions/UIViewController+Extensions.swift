//
// Created by soltan on 30/10/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {


    func showSpinner() -> SpinnerViewController {
        let child = SpinnerViewController()

        addChild(child)
        child.view.frame = view.frame

        view.addSubview(child.view)
        child.didMove(toParent: self)

        return child
    }

    func removeSpinner(spinner: SpinnerViewController?) {
        guard let spinner = spinner  else {return}
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }

    func runOnUIThread(sync: Bool = false, action: @escaping () -> Void) {
        if (sync) {
            DispatchQueue.main.sync {
                action()
            }
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}