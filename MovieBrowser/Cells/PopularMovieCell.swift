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
    
    func setContent(movieData: PopularMovie) {
        movieTitle.text = movieData.title
        
        task = AppClient.shared.getImage(imagePath: movieData.posterPath!, completionHandler: { [weak self ] result in
            if case let .success(imgData) = result {
                DispatchQueue.main.async {
                    self?.movieImage.image = UIImage(data: imgData)
                }
            }
            
        })
        
    }
    
    
    override func prepareForReuse() {
        task?.cancel()
        task = nil
    }
}
