//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 22.10.24.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let viewModel = SearchViewModel()
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }

    
    private func setupUI() {
        view.backgroundColor = .white
        
        searchBar.delegate = self
        searchBar.placeholder = "Search for movies"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            self?.isSearching = true
            self?.tableView.reloadData()
        }
        
        viewModel.onError = { errorMessage in
            print("Error: \(errorMessage)")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            tableView.reloadData()
        } else {
            viewModel.searchMovies(query: searchText)
            isSearching = true
        }
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        viewModel.searchMovies(query: query)
        viewModel.addToSearchHistory(query)
        isSearching = true
        searchBar.resignFirstResponder()
    }

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = false
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            let selectedMovie = viewModel.movies[indexPath.row]
            viewModel.addToSearchHistory(selectedMovie.title ?? "")
            let detailVC = MovieDetailsTableViewController(selectedMovie.id)
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let query = viewModel.searchHistory[indexPath.row]
            searchBar.text = query
            viewModel.searchMovies(query: query)
            isSearching = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? viewModel.movies.count : viewModel.searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        
        if isSearching {
            let movie = viewModel.movies[indexPath.row]
            cell.textLabel?.text = movie.title
        } else {
            let query = viewModel.searchHistory[indexPath.row]
            cell.textLabel?.text = query
        }
        
        return cell
    }
}
