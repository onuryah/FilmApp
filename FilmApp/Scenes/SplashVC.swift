//
//  ViewController.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import UIKit

protocol SplashDisplayLayer: BaseDelegateProtocol {
    func showMainPage()
    func transmitRemoteConfig(value: String)
}

final class SplashVC: BaseVC {
    
    @IBOutlet private weak var splashAnimationView: UIImageView!
    @IBOutlet private weak var remoteLabel: UILabel!
    
    var viewModel: SplashBusinessLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startAnimating()
    }
}

private extension SplashVC {
    func setupUI() {
        viewModel = SplashVM()
        viewModel?.view = self
        viewModel?.checkWhetherInternetConnection()
    }
    
    func startAnimating() {
        UIView.animate(withDuration: 1.0, animations: {
            self.splashAnimationView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { (finished) in
            UIView.animate(withDuration: 1.0, animations: {
                self.splashAnimationView.transform = CGAffineTransform.identity
            })
        }
    }
}

extension SplashVC: SplashDisplayLayer{
    func push(controller: UIViewController) {
        show(controller, sender: nil)
    }
    
    func transmitRemoteConfig(value: String) {
        self.remoteLabel.text = value
    }
    
    func showMainPage() {
        let viewModel = HomeVM()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        resultViewController.viewModel = viewModel
        push(controller: resultViewController)
    }
}
