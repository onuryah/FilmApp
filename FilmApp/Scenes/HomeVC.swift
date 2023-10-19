//
//  HomeVC.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import UIKit

class HomeVC: BaseVC {
    var viewModel: HomeBusinessLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
}
