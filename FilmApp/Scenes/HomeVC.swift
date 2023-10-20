//
//  HomeVC.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import UIKit

class HomeVC: BaseVC {
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
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
        viewModel?.delegate = self
        viewModel?.alertDelegate = self
        setDelegates()
        tableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        viewModel?.searchBarQuery = "?s=\(searchBar.text ?? "")&apikey=b508dfa4"
//        viewModel?.fetch()
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchBarQuery = "?s=\(searchBar.text ?? "")&apikey=b508dfa4&page=1"
        viewModel?.searchBarQuery = searchBarQuery
        viewModel?.fetchIfNeeded(searchQuery: searchBarQuery)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filmArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        let model = viewModel?.filmArray?[indexPath.row]
        cell.populate(film: model)
        return cell
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeVC: HomeTableViewDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
