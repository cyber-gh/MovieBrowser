//
//  PopularMovieCell.swift
//  MovieBrowser
//
//  Created by soltan on 31/10/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation
import UIKit

class PopularMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    var task : URLSessionTask? = nil

    override func dragStateDidChange(_ dragState: DragState) {
        super.dragStateDidChange(dragState)
        setupStyle()
    }

    private func setupStyle() {

        contentView.clipsToBounds = true
        movieImage.translatesAutoresizingMaskIntoConstraints = true

        let newImageSize = CGRect(x: 0, y: 0, width: contentView.frame.width, height: movieImage.bounds.height)
        movieImage.frame = newImageSize
        print("setting new size", newImageSize)
        movieImage.clipsToBounds = true
        layer.cornerRadius = 0.05 * contentView.frame.width
        layer.masksToBounds = true
    }

    func setContent(movieData: PopularMovie) {

        movieTitle.text = movieData.title
        
        task = AppClient.shared.getImage(imagePath: movieData.posterPath!, completionHandler: { [weak self ] result in
            if case let .success(imgData) = result {
                DispatchQueue.main.async {
                    self?.movieImage.image = UIImage(data: imgData)
                }
            }
            
        })

        setupStyle()
    }
    
    
    override func prepareForReuse() {
        task?.cancel()
        task = nil

    }
}
