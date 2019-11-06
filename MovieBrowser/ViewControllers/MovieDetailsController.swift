//
// Created by soltan on 06/11/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation
import UIKit
import YoutubePlayer_in_WKWebView

class MoviesDetailsViewController: UIViewController {

    let playerView = WKYTPlayerView()

    private func setupConstraints() {


        view.addSubview(playerView)
        playerView.frame = self.view.frame


        view.backgroundColor = .black
        playerView.backgroundColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        playerView.load(withVideoId: "Mc0TMWYTU_k")
    }
}