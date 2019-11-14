//
// Created by soltan on 13/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController<ContentView: UIView>: UIViewController {

    var contentView: ContentView {
        get {
            return (view as! ContentView)
        }
        set {

        }
    }

    override var view: UIView! {
        get {
            return super.view
        }
        set {
            super.view = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = ContentView()
    }
}


