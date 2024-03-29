//
//  DetailsVM.swift
//  FilmApp
//
//  Created by OnurAlp on 20.10.2023.
//

protocol DetailsBusinessLayer: AnyObject {
    var view: DetailsDisplayLayer? { get set }
    
    func fetch()
}

protocol ViewSetterDelegate: AnyObject {
    func setViews()
}

final class DetailsVM {
    weak var view: DetailsDisplayLayer?
    
    private var networkManager: NetworkManager<DetailsEndpointItem> = NetworkManager()
    
    private let filmId: String
    
    init(filmId: String) {
        self.filmId = filmId
    }
}

extension DetailsVM: DetailsBusinessLayer {
    func fetch() {
        networkManager.request(endpoint: .upcoming(query: filmId), type: Details.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
//                self.ratings = response.ratings ?? []
                self.view?.showDetails(details: response)
                self.view?.setCollectionData(with: response.ratings ?? [])
                self.logSelectedFilm(title: response.title)
            case .failure(let error):
                view?.createAlert(alertTitle: MainConstants.alert, failMessage: error.message)
            }
        }
    }
    
    // MARK: Private
    func logSelectedFilm(title: String?) {
        guard let title else { return }
        AnalyticsHelper.shared.logEvent(event: AnaltyticsConstants.showed_film_details,
                                        params: AnaltyticsConstants.selected_film,
                                        value: title)
    }
}
