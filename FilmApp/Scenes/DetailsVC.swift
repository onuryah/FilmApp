//
//  DetailsVC.swift
//  FilmApp
//
//  Created by OnurAlp on 20.10.2023.
//

import Foundation
import UIKit

final class DetailsVC: BaseVC {
    @IBOutlet weak private var filmImage: UIImageView!
    @IBOutlet weak private var yearLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var directorLabel: UILabel!
    @IBOutlet weak private var plotLabel: UILabel!
    @IBOutlet weak private var awardsLabel: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var nameLabel: UILabel!
    var viewModel: DetailsBusinessLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setDelegates()
        viewModel?.fetch()
    }
    
    private func setup() {
        viewModel?.alertDelegate = self
        viewModel?.delegate = self
        
        collectionView.register(DetailsCollectionViewCell.nib, forCellWithReuseIdentifier: DetailsCollectionViewCell.identifier)
        navigationController?.navigationBar.tintColor = .lightGray
        navigationController?.navigationBar.topItem?.title = ""
    }
}

extension DetailsVC: ViewSetterDelegate {
    func setViews() {
        SDWebImageHelper.shared.setImage(view: filmImage, urlString: viewModel?.details?.poster ?? "")
        let details = viewModel?.details
        nameLabel.text = details?.title
        yearLabel.text = details?.year
        genreLabel.text = details?.genre
        directorLabel.text = details?.director
        plotLabel.text = details?.plot
        awardsLabel.text = details?.awards
        collectionView.reloadData()
    }
}

extension DetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.details?.ratings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.identifier, for: indexPath) as! DetailsCollectionViewCell
        let model = viewModel?.details?.ratings?[indexPath.row]
        cell.populate(model: model)
        return cell
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
