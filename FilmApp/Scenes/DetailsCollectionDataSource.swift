//
//  DetailsCollectionDataSource.swift
//  FilmApp
//
//  Created by OnurAlp on 25.10.2023.
//

import Foundation
import UIKit

final class DetailsCollectionDataSource: NSObject {
    var ratings: [Rating] = []
}

extension DetailsCollectionDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ratings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.identifier,
                                                            for: indexPath) as? DetailsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = ratings[indexPath.row]
        cell.populate(model: model)
        return cell
    }
}
