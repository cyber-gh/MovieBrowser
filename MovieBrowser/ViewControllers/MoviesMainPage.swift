//
// Created by soltan on 13/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit


class MoviesMainPageViewController: BaseViewController<MoviesMainPageView>, Coordinable {
    weak var coordinator: Coordinator?

    let cellId = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Movie Browser"


        contentView.headerCollectionView.dataSource = self
        contentView.headerCollectionView.register(MovieCarouselCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

    }

}

extension MoviesMainPageViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
}

class MovieCarouselCollectionViewCell: UICollectionViewCell {
    let profileImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.layer.cornerRadius = 18
        button.clipsToBounds = true

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "Bob Lee"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        addSubview(profileImageButton)
        addSubview(nameLabel)

        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        contentView.backgroundColor = .green
        backgroundColor = .green
    }
}


class MoviesMainPageView: UIView {

    var headerCollectionView: UICollectionView!

    private func initialize() {
        let layout = ZoomAndSnapFlowLayout(itemSize: CGSize(width: 400, height: 300))
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
