//
//  HomeVC.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import UIKit

protocol BaseDelegateProtocol: AnyObject {
    func createAlert(alertTitle: String, failMessage: String)
}

class BaseVC: UIViewController {
    
}

extension BaseVC: BaseDelegateProtocol {
    func createAlert(alertTitle: String, failMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: failMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
