//
//  HomeVM.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import Foundation
import UIKit

protocol HomeDisplayLayer {
    func push(controller: UIViewController)
}

protocol HomeBusinessLayer {
    var filmArray: [Film]? { get set }
    var searchBarQuery: String? { get set}
    var delegate: HomeTableViewDelegate? { get set }
    var view: HomeDisplayLayer? { get set }
    var alertDelegate: BaseDelegateProtocol? { get set }
    
    func fetchIfNeeded(searchQuery: String)
}

protocol HomeTableViewDelegate: AnyObject {
    func reloadData()
}

final class HomeVM {
    var searchBarQuery: String?
    var filmArray: [Film]?
    private let networkManager: NetworkManager<MainEndpointItem> = NetworkManager()
    weak var delegate: HomeTableViewDelegate?
    var view: HomeDisplayLayer?
    var alertDelegate: BaseDelegateProtocol?
    
    private func fetch() {
        networkManager.request(endpoint: .upcoming(query: searchBarQuery ?? ""), type: Films.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.filmArray = response.search
                if filmArray?.isEmpty ?? true {
                    alertDelegate?.createAlert(alertTitle: "Alert", failMessage: response.error ?? "")
                } else {
                    self.delegate?.reloadData()
                }
            case .failure(let error):
                alertDelegate?.createAlert(alertTitle: "Alert", failMessage: error.message)
            }
        }
    }
    
    private func checkSearchBarEmpty() -> Bool {
        let isSearchBarEmpty = searchBarQuery == "?s=&apikey=b508dfa4&page=1"
        if isSearchBarEmpty {
            self.filmArray?.removeAll()
            self.delegate?.reloadData()
        }
        return isSearchBarEmpty
    }
    
    func fetchIfNeeded(searchQuery: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            if searchQuery == self.searchBarQuery && !self.checkSearchBarEmpty() {
                    self.fetch()
            }
        }
    }
}

extension HomeVM: HomeBusinessLayer {
}
