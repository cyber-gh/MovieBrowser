//
// Created by soltan on 13/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit


class MoviesMainPageViewController: BaseViewController, Coordinable {
    weak var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray
        navigationItem.title = "Movie Browser"
    }

}
