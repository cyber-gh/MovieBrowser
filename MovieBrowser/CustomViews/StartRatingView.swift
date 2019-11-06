//
// Created by soltan on 05/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class StarRatingView : UIStackView {

    required init(coder: NSCoder) {
        super.init(coder: coder)
        addStarViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addStarViews()
    }

    private func addStarViews() {
        for _ in 0..<5 {
            let image = UIImage(named: "starIcon")!.withRenderingMode(.alwaysTemplate)
            let transformedImage = image.colorImageByCompletion()
            let imageView = UIImageView()
            imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            imageView.contentMode = .scaleAspectFit

            imageView.image = transformedImage
            self.addArrangedSubview(imageView)
        }
    }

    func setRating(rating: Double = 10.0) {
        var ratio = rating / 2
        for imgView in self.subviews {
            if let imgView = imgView as? UIImageView {


                var completionPercentage = 1.0
                if (ratio <= 1) {
                    completionPercentage = ratio
                }
                imgView.image = imgView.image?.colorImageByCompletion(completionPercentage: completionPercentage)
                print(completionPercentage)
                ratio -= 1
                ratio = max(ratio, 0)
            }
        }
    }
}