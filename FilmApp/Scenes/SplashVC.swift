//
//  ViewController.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import UIKit

class SplashVC: BaseVC {
    @IBOutlet weak var splashAnimationView: UIImageView!
    @IBOutlet weak var remoteLabel: UILabel!
    var viewModel: SplashBusinessLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        startAnimating()
        viewModel?.checkWhetherInternetConnection()
    }
    
    private func startAnimating() {
        UIView.animate(withDuration: 1.0, animations: {
            self.splashAnimationView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { (finished) in
            UIView.animate(withDuration: 1.0, animations: {
                self.splashAnimationView.transform = CGAffineTransform.identity
            })
        }
    }
    
    private func setup() {
        viewModel = SplashVM()
        viewModel?.alertDelegate = self
        viewModel?.view = self
        viewModel?.remoteConfigDelegate = self
    }
}

extension SplashVC: SplashDisplayLayer{
    func push(controller: UIViewController) {
        show(controller, sender: nil)
    }
}

extension SplashVC: TransmitRemoteConfigDelegate {
    func transmitRemoteConfig(value: String) {
        DispatchQueue.main.async {
            self.remoteLabel.text = value
        }
    }
}

