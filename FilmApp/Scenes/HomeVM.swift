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

protocol HomeTableViewDelegate: AnyObject {
    func reloadData()
}

protocol ActicityIndicatorDelegate: AnyObject {
    func stopAnimating()
}

protocol HomeBusinessLayer {
    var filmArray: [Film]? { get set }
    var searchBarQuery: String? { get set}
    var delegate: HomeTableViewDelegate? { get set }
    var acticityDelegate: ActicityIndicatorDelegate? { get set }
    var view: HomeDisplayLayer? { get set }
    var alertDelegate: BaseDelegateProtocol? { get set }
    
    func fetchIfNeeded(searchQuery: String)
    func findCollectionCellSize(collectionViewSize: CGSize) -> CGSize
    func navigateToDetails(filmId: String)
    func needToFetchMore(indexPath: Int) -> Bool
}

final class HomeVM {
    weak var delegate: HomeTableViewDelegate?
    weak var acticityDelegate: ActicityIndicatorDelegate?
    var view: HomeDisplayLayer?
    var alertDelegate: BaseDelegateProtocol?
    
    var searchBarQuery: String?
    var filmArray: [Film]?
    private var pageOffSet: String = "1"
    private var totalResults: Int?
    private let networkManager: NetworkManager<MainEndpointItem> = NetworkManager()
    
    private func increasePageOffset() {
        pageOffSet = String((Int(pageOffSet) ?? 0) + 1)
    }
}

extension HomeVM: HomeBusinessLayer {
    private func fetch() {
        networkManager.request(endpoint: .upcoming(query: searchBarQuery ?? "", page: pageOffSet), type: Films.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.totalResults = Int(response.totalResults ?? "")
                self.filmArray = (self.filmArray ?? []) + (response.search ?? [])
                if response.search?.isEmpty ?? true {
                    alertDelegate?.createAlert(alertTitle: "Alert", failMessage: response.error ?? "")
                } else {
                    self.delegate?.reloadData()
                    increasePageOffset()
                }
            case .failure(let error):
                alertDelegate?.createAlert(alertTitle: "Alert", failMessage: error.message)
            }
            acticityDelegate?.stopAnimating()
        }
    }
    
    private func checkSearchBarEmpty() -> Bool {
        let isSearchBarEmpty = searchBarQuery == ""
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
    
    func findCollectionCellSize(collectionViewSize: CGSize) -> CGSize {
        let width = (collectionViewSize.width - 16) / 2
        let height = (collectionViewSize.height - 32) / 2.5
        return CGSize(width: width, height: height)
    }
    
    func navigateToDetails(filmId: String) {
        let viewModel = DetailsVM(filmId: filmId)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        resultViewController.viewModel = viewModel
        self.view?.push(controller: resultViewController)
    }
    
    func needToFetchMore(indexPath: Int) -> Bool {
        guard let content = filmArray, indexPath == content.count - 1, filmArray?.count != totalResults else { return false }
        fetchIfNeeded(searchQuery: searchBarQuery ?? "")
        return true
    }
}
