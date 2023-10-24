//
//  HomeVC.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import UIKit

protocol HomeDisplayLayer: BaseDelegateProtocol {
    func push(controller: UIViewController)
    func setCollectionData(with films: [Film])
    func startAnimating()
    func stopAnimating()
}

class HomeVC: BaseVC {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private let dataSource = HomeCollectionDataSource()
    
    var viewModel: HomeBusinessLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension HomeVC {
    func setupUI() {
        setupCollectionView()
        viewModel.view = self
        searchBar.delegate = self
        activityIndicator.hidesWhenStopped = true
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func setupCollectionView() {
        collectionView.register(HomeCollectionViewCell.nib, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        dataSource.delegate = self
    }
}

extension HomeVC: HomeDisplayLayer {
    func push(controller: UIViewController) {
        show(controller, sender: nil)
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    func setCollectionData(with films: [Film]) {
        dataSource.films = films
        collectionView.reloadData()
    }
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText)
    }
}

extension HomeVC: HomeCollectionDataSourceDelegate {
    func didSelect(imdbId: String) {
        let viewModel = DetailsVM(filmId: imdbId)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        resultViewController.viewModel = viewModel
        push(controller: resultViewController)
    }
    
    func checkNextPage() {
        viewModel.checkNextPage()
    }
}
