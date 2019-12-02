//
// Created by soltan on 02/12/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit


class MovieCarouselCollectionViewCell: UICollectionViewCell {


    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "Bob Lee"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let movieImage: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .yellow
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        addSubview(movieImage)
        addSubview(nameLabel)

        movieImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        movieImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        movieImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        movieImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true

        nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: movieImage.bottomAnchor, multiplier: 1.0).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        contentView.backgroundColor = .green
        backgroundColor = .green
    }

    func setContent(popularMovie: PopularMovie) {
        nameLabel.text = popularMovie.title
        if let path = popularMovie.backdropPath {
            getImageTask = AppClient.shared.getImage(imagePath: path, completionHandler: { [weak self] result in
                if case let .success(imgData) = result {
                    DispatchQueue.main.async { [weak self] in
                        let img = UIImage(data: imgData)
                        self?.movieImage.image = img
                    }
                }

            })
        }

    }

    var getImageTask : URLSessionTask? = nil

    override func prepareForReuse() {
        super.prepareForReuse()
        getImageTask?.cancel()
        getImageTask = nil
    }
}
