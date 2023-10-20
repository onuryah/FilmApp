//
//  HomeVC.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import UIKit

class HomeVC: BaseVC {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel: HomeBusinessLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension HomeVC: UISearchBarDelegate {
    private func setup() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        searchBar.delegate = self
        viewModel?.view = self
        viewModel?.delegate = self
        viewModel?.alertDelegate = self
        activityIndicator.hidesWhenStopped = true
        setDelegates()
        collectionView.register(HomeCollectionViewCell.nib, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        activityIndicator.startAnimating()
        let searchBarQuery = "?s=\(searchBar.text ?? "")&apikey=b508dfa4&page=1"
        viewModel?.searchBarQuery = searchBarQuery
        viewModel?.fetchIfNeeded(searchQuery: searchBarQuery)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.filmArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        let model = viewModel?.filmArray?[indexPath.row]
        cell.populate(film: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.navigateToDetails(filmId: viewModel?.filmArray?[indexPath.row].imdbID ?? "")
    }

    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel?.findCollectionCellSize(collectionViewSize: collectionView.bounds.size) ?? CGSize(width: 0, height: 0)
    }
}

extension HomeVC: HomeTableViewDelegate {
    func reloadData() {
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
}

extension HomeVC: HomeDisplayLayer {
    func push(controller: UIViewController) {
        show(controller, sender: nil)
    }
}
