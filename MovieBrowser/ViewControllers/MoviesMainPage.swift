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

        navigationItem.title = "Movie Browser"
        view = MoviesMainPageView()
        view.backgroundColor = .systemGray
    }

}

class MoviesMainPageView: UIView {

    let button = UIButton()

    private func initialize() {
        button.setTitle("Do something", for: .normal)
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true


    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
