//
//  HomeCollectionViewCell.swift
//  FilmApp
//
//  Created by OnurAlp on 20.10.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populate(film: Film?) {
        SDWebImageHelper.shared.setImage(view: filmImage, urlString: film?.poster ?? "")
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
