//
//  HomeVM.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import Foundation

protocol HomeDisplayLayer {
    
}

protocol HomeBusinessLayer {
    var filmArray: [Film]? { get set }
    var searchBarQuery: String? { get set}
    var delegate: HomeTableViewDelegate? { get set }
    
    func fetch()
}

protocol HomeTableViewDelegate: AnyObject {
    func reloadData()
}

final class HomeVM {
    var searchBarQuery: String?
    var filmArray: [Film]?
    private let networkManager: NetworkManager<MainEndpointItem> = NetworkManager()
    weak var delegate: HomeTableViewDelegate?
    
    func fetch() {
        networkManager.request(endpoint: .upcoming(query: searchBarQuery ?? ""), type: Films.self) { [weak self] result in
            guard let self = self else { return }
            print(searchBarQuery)
            switch result {
            case .success(let response):
                self.filmArray = response.search
                self.delegate?.reloadData()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension HomeVM: HomeBusinessLayer {
}
