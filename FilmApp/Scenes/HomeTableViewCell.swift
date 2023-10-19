//
//  HomeTableViewCell.swift
//  FilmApp
//
//  Created by OnurAlp on 19.10.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populate(film: Film?) {
        titleLabel.text = film?.title
    }
    
}

extension HomeTableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
