//
// Created by soltan on 13/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit


class MoviesMainPageViewController: BaseViewController<MoviesMainPageView>, Coordinable {
    weak var coordinator: Coordinator?

    var popularMoviesList = Array<PopularMovie>()

    let cellId = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Movie Browser"


        contentView.headerCollectionView.dataSource = self
        contentView.headerCollectionView.register(MovieCarouselCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        AppClient.shared.getPopularMovies {[weak self] result in
            if case let .success(res) = result {
                self?.popularMoviesList = res.results!
                self?.updateData()
            }
        }
    }

    func updateData() {
        contentView.headerCollectionView.reloadData()
    }

}

extension MoviesMainPageViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMoviesList.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCarouselCollectionViewCell

        cell.setContent(popularMovie: popularMoviesList[indexPath.row])

        return cell
    }
}



