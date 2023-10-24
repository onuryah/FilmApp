//
//  HomeVM.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import Foundation

protocol HomeBusinessLayer: AnyObject {
    var view: HomeDisplayLayer? { get set }
    
    func checkNextPage()
    func search(query: String)
}

final class HomeVM {
    weak var view: HomeDisplayLayer?
    
    private var films: [Film] = []
    private var pageOffSet: Int = 1
    private var totalResults: Int?
    private let networkManager: NetworkManager<MainEndpointItem> = NetworkManager()
    private var lastSearchedValue: String?
    private var timer: Timer?
}

extension HomeVM: HomeBusinessLayer {
    func search(query: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] timer in
            guard let self = self else { return }
            self.checkSearchTextChange(with: query)
        }
    }
    
    func checkNextPage() {
        guard let totalResults,
              let lastSearchedValue,
              totalResults > films.count else { return }
        fetch(with: lastSearchedValue)
    }
}

private extension HomeVM {
    func clearAll() {
        films.removeAll()
        view?.setCollectionData(with: films)
    }
    
    func checkSearchTextChange(with query: String) {
        if query.isEmpty {
            clearAll()
            return
        }
        
        if lastSearchedValue == query {
            return
        }
        
        if lastSearchedValue != query {
            lastSearchedValue = query
            pageOffSet = 1
            clearAll()
        }
        
        fetch(with: query)
    }
    
    func fetch(with query: String) {
        view?.startAnimating()
        networkManager.request(endpoint: .upcoming(query: query, page: pageOffSet),
                               type: Films.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handleSuccess(with: response)
            case .failure(let error):
                self.view?.createAlert(alertTitle: MainConstants.alert,
                                       failMessage: error.message)
            }
            self.view?.stopAnimating()
        }
    }
    
    func handleSuccess(with response: Films) {
        guard let newFilms = response.search,
              let newTotalResults = response.totalResults,
              !newFilms.isEmpty else {
            view?.createAlert(alertTitle: MainConstants.alert,
                              failMessage: response.error ?? "")
            return
        }
        
        self.totalResults = Int(newTotalResults)
        self.films.append(contentsOf: newFilms)
        view?.setCollectionData(with: films)
        pageOffSet += 1
    }
}
