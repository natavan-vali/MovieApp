import UIKit

class FavoritesViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = FavoritesViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchFavorites()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.register(ImageAndTitleCell.self, forCellReuseIdentifier: ImageAndTitleCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func fetchFavorites() {
        guard let userId = AuthManager.shared.getCurrentUserId() else { return }
        
        viewModel.fetchFavorites(userId)
        
        viewModel.success = {
            DispatchQueue.main.async {
                self.viewModel.favorites.sort { $0.createdAt < $1.createdAt }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        viewModel.error = { errorMessage in
            self.showErrorAlert(message: errorMessage)
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refreshData() {
        fetchFavorites()
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movies = viewModel.favorites.filter { $0.type == "movie" }
        let series = viewModel.favorites.filter { $0.type == "series" }
        
        let media: MediaData
        if indexPath.section == 0 {
            media = !movies.isEmpty ? movies[indexPath.row] : series[indexPath.row]
        } else {
            media = series[indexPath.row]
        }
        
        if media.type == "movie" {
            let movieDetailsVC = MovieDetailsTableViewController(media.id)
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        } else if media.type == "series" {
            let tvSeriesDetailsVC = TVSeriesDetailsTableViewController(media.id)
            navigationController?.pushViewController(tvSeriesDetailsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let hasMovies = viewModel.favorites.contains(where: { $0.type == "movie" })
        let hasTVSeries = viewModel.favorites.contains(where: { $0.type == "series" })
        
        return (hasMovies ? 1 : 0) + (hasTVSeries ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let movies = viewModel.favorites.filter { $0.type == "movie" }
        let series = viewModel.favorites.filter { $0.type == "series" }
        
        if section == 0 {
            return !movies.isEmpty ? movies.count : series.count
        } else if section == 1 {
            return series.count
        }
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageAndTitleCell.reuseIdentifier, for: indexPath) as! ImageAndTitleCell
        
        let movies = viewModel.favorites.filter { $0.type == "movie" }
        let series = viewModel.favorites.filter { $0.type == "series" }
        
        let media: MediaData
        if indexPath.section == 0 {
            media = !movies.isEmpty ? movies[indexPath.row] : series[indexPath.row]
        } else {
            media = series[indexPath.row]
        }
        
        cell.configure(with: media.title, imageURL: URL(string: media.posterURL))
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let movies = viewModel.favorites.filter { $0.type == "movie" }
        let series = viewModel.favorites.filter { $0.type == "series" }
        
        if section == 0 {
            return !movies.isEmpty ? "Movies" : "TV Series"
        } else if section == 1 {
            return "TV Series"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let movies = viewModel.favorites.filter { $0.type == "movie" }
        let series = viewModel.favorites.filter { $0.type == "series" }
        
        let favorite: MediaData
        if indexPath.section == 0 {
            favorite = !movies.isEmpty ? movies[indexPath.row] : series[indexPath.row]
        } else {
            favorite = series[indexPath.row]
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self else { return }
            if let userId = AuthManager.shared.getCurrentUserId() {
                self.viewModel.removeFromFavorites(favorite, userId)
                self.fetchFavorites()
                completion(true)
            }
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
