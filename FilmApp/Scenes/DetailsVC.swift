//
//  DetailsVC.swift
//  FilmApp
//
//  Created by OnurAlp on 20.10.2023.
//

import Foundation
import UIKit

final class DetailsVC: BaseVC {
    var viewModel: DetailsBusinessLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.fetch()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            print("heyy", self.viewModel?.details?.ratings)
        }
    }
    
    private func setup() {
        viewModel?.alertDelegate = self
    }
}
