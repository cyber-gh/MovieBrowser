//
// Created by soltan on 13/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit


class MoviesMainPageViewController: BaseViewController<MoviesMainPageView>, Coordinable {
    weak var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Movie Browser"

    }

}


class MoviesMainPageView: UIView {

    var headerCollectionView: UICollectionView!

    private func initialize() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100.0, height: 100.0)
        headerCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.addSubview(headerCollectionView)

        headerCollectionView.translatesAutoresizingMaskIntoConstraints = false

        headerCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
        headerCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        headerCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerCollectionView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true

        headerCollectionView.backgroundColor = .red
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
