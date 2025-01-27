import UIKit

class TVSeriesViewController: UIViewController {
    var viewModel = TVSeriesViewModel()
    var collectionViews = [UICollectionView]()
    
    let favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        let filledHeartImage = UIImage(systemName: "heart.fill")
        button.setImage(filledHeartImage, for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TV Series"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bindViewModel()
        viewModel.fetchTVSeries()
        
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
    }
    
    @objc func favoritesButtonTapped() {
        let favoritesVC = FavoritesViewController()
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
    
    @objc func settingsButtonTapped() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func bindViewModel() {
        viewModel.success = { [weak self] in
            DispatchQueue.main.async {
                self?.setupCollectionViews()
                self?.contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
                self?.populateContentStackView()
            }
        }
        
        viewModel.error = { [weak self] message in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: message)
            }
        }
    }
    
    func setupCollectionViews() {
        collectionViews = viewModel.items.map { _ in createCollectionView() }
    }
    
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(favoritesButton)
        view.addSubview(settingsButton)
        view.addSubview(collectionView)
        collectionView.addSubview(contentStackView)
    }
    
    func populateContentStackView() {
        for (index, item) in viewModel.items.enumerated() {
            let sectionLabel = UILabel()
            sectionLabel.text = item.title
            sectionLabel.font = .systemFont(ofSize: 20)
            
            contentStackView.addArrangedSubview(sectionLabel)
            contentStackView.addArrangedSubview(collectionViews[index])
            
            collectionViews[index].heightAnchor.constraint(equalToConstant: 200).isActive = true
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            favoritesButton.topAnchor.constraint(equalTo: settingsButton.topAnchor),
            favoritesButton.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: favoritesButton.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: collectionView.widthAnchor)
        ])
    }
}

extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let index = collectionViews.firstIndex(of: collectionView) else { return 0 }
        return viewModel.items[index].series.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as! ContentCollectionViewCell
        guard let index = collectionViews.firstIndex(of: collectionView) else { return cell }
        let series = viewModel.items[index].series[indexPath.item]
        cell.configure(data: series)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let index = collectionViews.firstIndex(of: collectionView) else { return }
        let selectedSeriesId = viewModel.items[index].series[indexPath.item].id
        let detailsVC = TVSeriesDetailsTableViewController(selectedSeriesId)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension TVSeriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}
