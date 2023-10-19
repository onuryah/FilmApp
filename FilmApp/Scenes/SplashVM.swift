//
//  SplashVM.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import Foundation
import Alamofire
import UIKit

protocol SplashDisplayLayer {
    func push(controller: UIViewController)
}

protocol SplashBusinessLayer {
    var view: SplashDisplayLayer? { get set }
    var alertDelegate: BaseDelegateProtocol? { get set }
    
    func checkWhetherInternetConnection()
}

final class SplashVM{
    var view: SplashDisplayLayer?
    var alertDelegate: BaseDelegateProtocol?
}

extension SplashVM: SplashBusinessLayer {
    func checkWhetherInternetConnection() {
        if !((NetworkReachabilityManager()?.isReachable) != nil) {
            alertDelegate?.createAlert(alertTitle: "Network Connection Fail", failMessage: "Please check your internet connection!")
        } else {
            navigateToHome()
        }
    }
}

extension SplashVM {
    private func navigateToHome() {
        let viewModel = HomeVM()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        resultViewController.viewModel = viewModel
        self.view?.push(controller: resultViewController)
    }
}
