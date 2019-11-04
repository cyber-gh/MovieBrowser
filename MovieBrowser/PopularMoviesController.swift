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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        viewModel.dataLoadedListener = self
        spinnner = showSpinner()
        viewModel.loadData()
        
    }

    private func initCollectionView() {
        collectionView.dataSource = self
        flowLayout = ZoomAndSnapFlowLayout(itemSize: CGSize(width: collectionView.frame.width * 0.5, height: collectionView.frame.height * 0.75))
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self

    }

    private func updateMovieLabel(currentItemIndex indexPath: IndexPath?) {
        guard let indexPath = indexPath else {return }
        
        currentMovieNameLbl.text = viewModel.data[indexPath.row].title
        currentMoviewOverview.text = viewModel.data[indexPath.row].overview
        
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

class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {

    let activeDistance: CGFloat = 200
    let zoomFactor: CGFloat = 0.3

    override init() {
        super.init()

        scrollDirection = .horizontal
        minimumLineSpacing = 40
        itemSize = CGSize(width: 160, height: 150)
    }

    convenience init(itemSize: CGSize) {
        self.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 60
        self.itemSize = itemSize
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)

        super.prepare()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)

        // Make the cells be zoomed when they reach the center of the screen
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = distance / activeDistance

            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }

        return rectAttributes
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }

        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
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
//        if (collectionView.visibleCells.count == 2) {
//            let indexPath = collectionView.indexPath(for: collectionView.visibleCells[0])
//            self.updateMovieLabel(currentItemIndex: indexPath)
//        }
//        if (collectionView.visibleCells.count == 3) {
//            let indexPath = collectionView.indexPath(for: collectionView.visibleCells[1])
//            self.updateMovieLabel(currentItemIndex: indexPath)
//        }


        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        self.updateMovieLabel(currentItemIndex: visibleIndexPath)

    }

    public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        self.updateMovieLabel(currentItemIndex: visibleIndexPath)
    }

}
