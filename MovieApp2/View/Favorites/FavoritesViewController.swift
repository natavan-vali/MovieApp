import UIKit
import FirebaseFirestore
import FirebaseAuth

class FavoritesViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = FavoritesViewModel()
    
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
    }
    
    private func fetchFavorites() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        viewModel.fetchFavorites(userId)
        
        viewModel.success = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.error = { errorMessage in
            self.showErrorAlert(message: errorMessage)
        }
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {  
            let movie = viewModel.favorites[indexPath.row]
            let movieDetailsVC = MovieDetailsTableViewController(movie.id)
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        } else {
            let tvSeries = viewModel.favorites[indexPath.row]
            let tvSeriesDetailsVC = TVSeriesDetailsTableViewController(tvSeries.id)
            navigationController?.pushViewController(tvSeriesDetailsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150.0
        }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections = 0
        if !viewModel.favorites.filter({ $0.type == "movie" }).isEmpty {
            sections += 1
        }
        if !viewModel.favorites.filter({ $0.type == "series" }).isEmpty {
            sections += 1
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && !viewModel.favorites.filter({ $0.type == "movie" }).isEmpty {
            return viewModel.favorites.filter { $0.type == "movie" }.count
        } else if section == 1 && !viewModel.favorites.filter({ $0.type == "series" }).isEmpty {
            return viewModel.favorites.filter { $0.type == "series" }.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageAndTitleCell.reuseIdentifier, for: indexPath) as! ImageAndTitleCell
        
        let filteredMovies = viewModel.favorites.filter { $0.type == "movie" }
        let filteredTVSeries = viewModel.favorites.filter { $0.type == "series" }
        
        if indexPath.section == 0 {
            let media = filteredMovies[indexPath.row]
            cell.configure(with: media.title, imageURL: URL(string: media.posterURL))
        } else if indexPath.section == 1 {
            let media = filteredTVSeries[indexPath.row]
            cell.configure(with: media.title, imageURL: URL(string: media.posterURL))
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let movies = viewModel.favorites.filter { $0.type == "movie" }
        let tvSeries = viewModel.favorites.filter { $0.type == "series" }
        
        if !movies.isEmpty && section == 0 {
            return "Favorite Movies"
        } else if !tvSeries.isEmpty && section == (movies.isEmpty ? 0 : 1) {
            return "Favorite TV Series"
        }
        return nil
    }
}
