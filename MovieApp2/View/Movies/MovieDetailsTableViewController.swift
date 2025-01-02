import UIKit
import FirebaseAuth

class MovieDetailsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel = MovieDetailsViewModel()
    private var tableView: UITableView!
    var favoritesViewModel = FavoritesViewModel()
    
    let favoritesButton: FavoritesButton = {
        let button = FavoritesButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(_ selectedMovieId: Int) {
        self.viewModel.selectedMovieId = selectedMovieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        viewModel.fetchMovieDetails()
        
        viewModel.success = { [weak self] movieDetails in
            DispatchQueue.main.async {
                self?.viewModel.selectedMovie = movieDetails
                self?.setupTableView()
            }
        }
        
        favoritesViewModel.fetchFavorites(userId)
        
        favoritesViewModel.success = {
            DispatchQueue.main.async {
                self.updateFavoritesButtonState()
            }
        }
        
        viewModel.error = { [weak self] errorMessage in
            self?.showErrorAlert(message: errorMessage)
        }

        favoritesButton.onTap = { [weak self] in
            guard let self = self, let movie = self.viewModel.selectedMovie else { return }
            
            let movieData = MediaData(id: movie.id,
                                      title: movie.title ?? "",
                                      type: "movie",
                                      posterURL: movie.posterURL)
            
            if self.favoritesViewModel.favorites.contains(where: { $0.id == movieData.id }) {
                self.favoritesViewModel.removeFromFavorites(movieData, userId)
                self.favoritesButton.setFavoriteState(false)
            } else {
                self.favoritesViewModel.addToFavorites(movieData, userId)
                self.favoritesButton.setFavoriteState(true)
            }
        }
        
        let favoritesBarButtonItem = UIBarButtonItem(customView: favoritesButton)
        navigationItem.rightBarButtonItem = favoritesBarButtonItem
    }
    
    private func updateFavoritesButtonState() {
        guard let movie = viewModel.selectedMovie else { return }
            
        let isFavorite = favoritesViewModel.favorites.contains(where: { $0.id == movie.id })
        favoritesButton.setFavoriteState(isFavorite)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(ImageCell.self, forCellReuseIdentifier: "BackdropCell")
        tableView.register(TitleCell.self, forCellReuseIdentifier: "TitleCell")
        tableView.register(InfoCell.self, forCellReuseIdentifier: "InfoCell")
        tableView.register(TextCell.self, forCellReuseIdentifier: "OverviewCell")
        tableView.register(GenreCell.self, forCellReuseIdentifier: "GenreCell")
        tableView.register(DurationCell.self, forCellReuseIdentifier: "DurationCell")
        tableView.register(DirectorCell.self, forCellReuseIdentifier: "DirectorCell")
        
        view.addSubview(tableView)
        view.addSubview(favoritesButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BackdropCell", for: indexPath) as? ImageCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(with: viewModel.selectedMovie?.backdropURL ?? "")
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(with: viewModel.selectedMovie?.title ?? "Unknown Title")
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell", for: indexPath) as? TextCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(with: viewModel.selectedMovie?.overview ?? "No Overview Available")
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(
                language: LanguageHelper.languageName(for: viewModel.selectedMovie?.language),
                popularity: "\(viewModel.selectedMovie?.popularity ?? 0)",
                rating: "\(viewModel.selectedMovie?.rating ?? 0)/10"
            )
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as? GenreCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(with: viewModel.selectedMovie?.genres?.map { $0.name }.joined(separator: ", ") ?? "Unknown Genre")
            return cell
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DurationCell", for: indexPath) as? DurationCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            if let runtime = viewModel.selectedMovie?.runtime {
                cell.configure(with: "\(runtime) min")
            } else {
                cell.configure(with: "N/A")
            }
            return cell
            
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DirectorCell", for: indexPath) as? DirectorCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(with: viewModel.selectedMovie?.productionCompanies?.map { $0.name }.joined(separator: ", ") ?? "No production companies available")
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        default:
            return UITableView.automaticDimension
        }
    }
}
