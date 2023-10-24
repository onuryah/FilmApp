//
//  SplashVM.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import Foundation
import Alamofire
import UIKit

protocol TransmitRemoteConfigDelegate: AnyObject {
    func transmitRemoteConfig(value: String)
}

protocol SplashDisplayLayer {
    func push(controller: UIViewController)
}

protocol SplashBusinessLayer {
    var view: SplashDisplayLayer? { get set }
    var alertDelegate: BaseDelegateProtocol? { get set }
    var remoteConfigDelegate: TransmitRemoteConfigDelegate? { get set }
    
    func checkWhetherInternetConnection()
}

final class SplashVM{
    var view: SplashDisplayLayer?
    var alertDelegate: BaseDelegateProtocol?
    weak var remoteConfigDelegate: TransmitRemoteConfigDelegate?
}

extension SplashVM: SplashBusinessLayer {
    func checkWhetherInternetConnection() {
        if !(NetworkReachabilityManager()?.isReachable ?? false) {
            alertDelegate?.createAlert(alertTitle: MainConstants.networkFail, failMessage: MainConstants.checkTheInternet)
        } else {
            getRemoteConfig()
        }
    }
    
    func getRemoteConfig() {
        RemoteConfigHelper.shared.getRemoteConfig { [weak self] (stringValue: String?) in
            guard let self = self else { return }
            guard let value = stringValue else {
                alertDelegate?.createAlert(alertTitle: MainConstants.fail, failMessage: MainConstants.couldntFindRemoteConfig)
                return
            }
            remoteConfigDelegate?.transmitRemoteConfig(value: value)
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                self.navigateToHome()
            }
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
