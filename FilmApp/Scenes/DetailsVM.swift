//
//  DetailsVM.swift
//  FilmApp
//
//  Created by OnurAlp on 20.10.2023.
//

import Foundation

protocol DetailsBusinessLayer {
    var filmId: String { get set }
    var alertDelegate: BaseDelegateProtocol? { get set }
    var details: Details? { get set }
    var delegate: ViewSetterDelegate? { get set }
    
    func fetch()
}

protocol ViewSetterDelegate {
    func setViews()
}

class DetailsVM {
    var filmId: String
    var networkManager: NetworkManager<MainEndpointItem>
    var details: Details?
    var alertDelegate: BaseDelegateProtocol?
    var delegate: ViewSetterDelegate?
    
    init(filmId: String, networkManager: NetworkManager<MainEndpointItem>) {
        self.filmId = filmId
        self.networkManager = networkManager
    }
}

extension DetailsVM: DetailsBusinessLayer {
    func fetch() {
        let film = "?i=\(filmId)&apikey=b508dfa4"
        networkManager.request(endpoint: .upcoming(query: film), type: Details.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.details = response
                delegate?.setViews()
            case .failure(let error):
                alertDelegate?.createAlert(alertTitle: "Alert", failMessage: error.message)
            }
        }
    }

}
