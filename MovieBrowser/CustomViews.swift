//
// Created by soltan on 05/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class StarRatingView : UIStackView {

    private var starViews : [UIImageView] = []

    required init(coder: NSCoder) {
        super.init(coder: coder)
        addStarViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addStarViews()
    }

    private func addStarViews() {
        for i in 0..<5 {
            let image = UIImage(named: "starIcon")!.withRenderingMode(.alwaysTemplate)
            let transformedImage = image.colorImageByCompletion()
            let imageView = UIImageView()
            imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            imageView.contentMode = .scaleAspectFit

            imageView.image = transformedImage
            starViews.append(imageView)
            self.addArrangedSubview(imageView)
        }
    }

//    func setRating(rating: Double = 10.0) {
//        var ratio = rating / 2
//        for imgView in starViews {
//            imgView.image
//        }
//    }
}