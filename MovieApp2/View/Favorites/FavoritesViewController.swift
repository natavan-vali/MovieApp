////
////  FavoritesViewController.swift
////  MovieApp
////
////  Created by Natavan Valiyeva on 10.12.24.
////
//
//import UIKit
//
//class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(ImageAndTitleCell.self, forCellReuseIdentifier: ImageAndTitleCell.reuseIdentifier)
//        return tableView
//    }()
//    
//    private var favorites: [Content] = [] // Content modelləri burada saxlanılır.
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        loadFavorites()
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .white
//        view.addSubview(tableView)
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    private func loadFavorites() {
//        // Simulyasiya edilmiş favoritlər
//        favorites = [
//            Content(title: "Inception", imageURL: URL(string: "https://example.com/inception.jpg")),
//            Content(title: "Breaking Bad", imageURL: URL(string: "https://example.com/breakingbad.jpg")),
//            Content(title: "Avatar", imageURL: URL(string: "https://example.com/avatar.jpg"))
//        ]
//        tableView.reloadData()
//    }
//    
//    // MARK: - UITableViewDataSource
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return favorites.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ImageAndTitleCell.reuseIdentifier, for: indexPath) as! ImageAndTitleCell
//        let content = favorites[indexPath.row]
//        cell.configure(with: content)
//        return cell
//    }
//    
//    // MARK: - UITableViewDelegate
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let selectedContent = favorites[indexPath.row]
//        // Seçilmiş film/serial üçün navigation və ya detallar səhifəsi əlavə edin.
//    }
//}
