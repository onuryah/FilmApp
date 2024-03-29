//
//  HomeCollectionViewCell.swift
//  FilmApp
//
//  Created by OnurAlp on 20.10.2023.
//

import UIKit
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    
    func populate(film: Film?) {
        filmImage.sd_setImage(with: film?.poster.URLFormat)
    }

}

extension HomeCollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
