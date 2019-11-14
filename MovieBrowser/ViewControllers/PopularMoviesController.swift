//
//  PopularMoviesController.swift
//  MovieBrowser
//
//  Created by soltan on 31/10/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation
import UIKit

protocol DataStateListener : class {
    func dataDidFinishLoading()
}

class PopularMoviesViewModel  {

    weak var dataLoadedListener: DataStateListener? = nil

    var data : [PopularMovie] = [] {
        didSet {
            dataLoadedListener?.dataDidFinishLoading()
        }
    }

    var lastDisplayedElementIndex = -1

    func loadData() {
        AppClient.shared.getPopularMovies(page: 1) { [weak self] (v: Result<PopularMoviesResult, Error>) in
            if case let .success(result) = v{
                if let movies = result.results {
                    self?.data = movies
                }
            }
        }
    }


}

class PopularMoviesViewController : UIViewController {

    let viewModel = PopularMoviesViewModel()
    let cellIdentifier = "popularMovieCell"
    var flowLayout : ZoomAndSnapFlowLayout!

    @IBOutlet weak var currentMovieNameLbl: UILabel!
    var spinnner: SpinnerViewController? = nil

    @IBOutlet weak var currentMoviewOverview: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageTitleLbl: UILabel!
    
    @IBOutlet weak var starRatingView: StarRatingView!
    var lastVelocityXSign = 0

    private func setupStyle() {
        pageTitleLbl.textColor = .primaryTextColor
        currentMovieNameLbl.textColor = .primaryTextColor
        currentMoviewOverview.textColor = .secondaryTextColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        initCollectionView()
        viewModel.dataLoadedListener = self
        spinnner = showSpinner()
        viewModel.loadData()


        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openDetailsController))
        currentMovieNameLbl.addGestureRecognizer(tapGesture)
        currentMovieNameLbl.isUserInteractionEnabled = true

    }

    @objc func openDetailsController(sender: UITapGestureRecognizer) {
        //let detailsViewController = MoviesDetailsViewController()
//        self.present(detailsViewController, animated: true)
    }

    private func initCollectionView() {
        collectionView.dataSource = self
        flowLayout = ZoomAndSnapFlowLayout(itemSize: CGSize(width: collectionView.frame.width * 0.45, height: collectionView.frame.height * 0.72))
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self

    }

    private func updateMovieLabel(currentItemIndex indexPath: IndexPath?) {
        guard let indexPath = indexPath, viewModel.lastDisplayedElementIndex != indexPath.row else {
            return
        }
        viewModel.lastDisplayedElementIndex = indexPath.row
        //scroll direction, adapt animations
        var animationDirection : CATransitionSubtype? = nil
        if (lastVelocityXSign < 0) {
            animationDirection = .fromRight
        } else if (lastVelocityXSign > 0){
            animationDirection = .fromLeft

        }
        
        currentMovieNameLbl.setTextAnimated(newText: viewModel.data[indexPath.row].title, transType: .push, transSubtype: animationDirection)
        currentMoviewOverview.setTextAnimated(newText: viewModel.data[indexPath.row].overview, transType: .reveal, transSubtype: animationDirection)
        starRatingView.setRating(rating: viewModel.data[indexPath.row].voteAverage!)
    }
}

extension PopularMoviesViewController : DataStateListener {
    func dataDidFinishLoading() {
        DispatchQueue.main.async { [weak self ] in
            self?.removeSpinner(spinner: self?.spinnner)
            self?.spinnner = nil
            self?.collectionView.reloadData()
            self?.updateMovieLabel(currentItemIndex: IndexPath(row: 0, section: 0))
        }

    }
}


extension PopularMoviesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PopularMovieCell
        cell.setContent(movieData: viewModel.data[indexPath.row])
        return cell
    }
}

extension PopularMoviesViewController : UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        self.updateMovieLabel(currentItemIndex: visibleIndexPath)

    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentVelocityX = scrollView.panGestureRecognizer.velocity(in: scrollView.superview).x

        let currentVelocityXSign = Int(currentVelocityX).signum()
        if (currentVelocityXSign != lastVelocityXSign && currentVelocityXSign != 0) {
            lastVelocityXSign = currentVelocityXSign
        }
    }
}
