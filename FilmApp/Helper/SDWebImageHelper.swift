//
//  SDWebImageHelper.swift
//  FilmApp
//
//  Created by OnurAlp on 19.10.2023.
//

import UIKit
import SDWebImage

class SDWebImageHelper {
    static let shared = SDWebImageHelper()
    
    func setImage(view: UIImageView, urlString: String) {
        guard let url = URL(string: urlString) else { return }
        view.sd_setImage(with: url)
    }
}
