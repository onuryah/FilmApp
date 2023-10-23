//
//  RatingCollectionViewCell.swift
//  FilmApp
//
//  Created by OnurAlp on 23.10.2023.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func populate(model: Rating?) {
        sourceLabel.text = model?.source
        valueLabel.text = model?.value
    }
}

extension DetailsCollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

