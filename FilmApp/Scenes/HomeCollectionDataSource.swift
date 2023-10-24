//
//  HomeCollectionDataSource.swift
//  FilmApp
//
//  Created by OnurAlp on 24.10.2023.
//

import UIKit

protocol HomeCollectionDataSourceDelegate: AnyObject {
    func didSelect(imdbId: String)
    func checkNextPage()
}

final class HomeCollectionDataSource: NSObject {
    weak var delegate: HomeCollectionDataSourceDelegate?
    
    var films: [Film] = []
}

extension HomeCollectionDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if films.count == (indexPath.row + 1) {
            delegate?.checkNextPage()
        }
    }
}

extension HomeCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier,
                                                            for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = films[indexPath.row]
        cell.populate(film: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let imdbId = films[indexPath.row].imdbID else { return }
        delegate?.didSelect(imdbId: imdbId)
    }
}

extension HomeCollectionDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        
        let width = (size.width - 16) / 2
        let height = (size.height - 32) / 2.5
        return CGSize(width: width, height: height)
    }
}
