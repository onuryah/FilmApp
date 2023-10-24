//
//  DetailsVC.swift
//  FilmApp
//
//  Created by OnurAlp on 20.10.2023.
//

import Foundation
import UIKit
import Lottie

protocol DetailsDisplayLayer: BaseDelegateProtocol {
    func showDetails(details: Details)
}

final class DetailsVC: BaseVC {
    @IBOutlet weak private var filmImage: UIImageView!
    @IBOutlet weak private var yearLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var directorLabel: UILabel!
    @IBOutlet weak private var plotLabel: UILabel!
    @IBOutlet weak private var awardsLabel: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var waitingView: UIView!
    @IBOutlet weak private var animationView: LottieAnimationView!
    var viewModel: DetailsBusinessLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setDelegates()
        viewModel?.fetch()
    }
}

extension DetailsVC: DetailsDisplayLayer {
    func showDetails(details: Details) {
        nameLabel.text = details.title
        yearLabel.text = details.year
        genreLabel.text = details.genre
        directorLabel.text = details.director
        plotLabel.text = details.plot
        awardsLabel.text = details.awards
        waitingView.isHidden = true
        filmImage.sd_setImage(with: details.poster.URLFormat)
        collectionView.reloadData()
    }
}

extension DetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.ratings.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.identifier, for: indexPath) as! DetailsCollectionViewCell
        let model = viewModel?.ratings[indexPath.row]
        cell.populate(model: model)
        return cell
    }
}

private extension DetailsVC {
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setup() {
        viewModel?.view = self
        
        collectionView.register(DetailsCollectionViewCell.nib, forCellWithReuseIdentifier: DetailsCollectionViewCell.identifier)
        setLottie()
        navigationController?.navigationBar.tintColor = .lightGray
        navigationController?.navigationBar.topItem?.title = ""
    }

    private func setLottie() {
        animationView.animation = LottieAnimation.named("lottie")
        animationView.play()
        animationView.loopMode = .loop
    }
}
