//
//  SplashVM.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import Foundation
import Alamofire

protocol SplashBusinessLayer: AnyObject {
    var view: SplashDisplayLayer? { get set }
    
    func checkWhetherInternetConnection()
}

final class SplashVM {
    weak var view: SplashDisplayLayer?
}

extension SplashVM: SplashBusinessLayer {
    func checkWhetherInternetConnection() {
        guard (NetworkReachabilityManager()?.isReachable ?? false) else {
            view?.createAlert(alertTitle: MainConstants.networkFail, failMessage: MainConstants.checkTheInternet)
            return
        }
        
        getRemoteConfig()
    }
}

private extension SplashVM {
    func getRemoteConfig() {
        RemoteConfigHelper.shared.getRemoteConfig { [weak self] (stringValue: String?) in
            guard let self = self,
                  let value = stringValue else {
                self?.view?.createAlert(alertTitle: MainConstants.fail, failMessage: MainConstants.couldntFindRemoteConfig)
                return
            }
            
            DispatchQueue.main.async {
                self.view?.transmitRemoteConfig(value: value)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                self.view?.showMainPage()
            }
        }
    }
}
