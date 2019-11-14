//
// Created by soltan on 13/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController<ContentView: UIView>: UIViewController {

    var contentView: ContentView!

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = ContentView()
        contentView.frame = view.frame
        view.addSubview(contentView)
        if #available(iOS 13.0, *) {
            contentView.backgroundColor = .systemBackground
        }

        if let navigationBar = navigationController?.navigationBar {
            view.addSubview(navigationBar)
            contentView.topAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
        }
    }
}


