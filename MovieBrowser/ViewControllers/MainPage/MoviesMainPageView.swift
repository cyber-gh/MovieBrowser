//
// Created by soltan on 02/12/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit


class MoviesMainPageView: UIView {

    var headerCollectionView: UICollectionView!

    private func initialize() {
        let layout = ZoomAndSnapFlowLayout()
        layout.scrollDirection = .horizontal
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