//
//  ViewController.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import UIKit

class SplashVC: BaseVC {
    var viewModel: SplashBusinessLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.checkWhetherInternetConnection()
    }
    
    private func setup() {
        viewModel = SplashVM()
        viewModel?.alertDelegate = self
        viewModel?.view = self
    }
}

extension SplashVC: SplashDisplayLayer{
    func push(controller: UIViewController) {
        show(controller, sender: nil)
    }
}

