import UIKit

class PersonDetailsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel = PersonDetailsViewModel()
    private var tableView: UITableView!
    
    init(_ selectedPersonId: Int) {
        self.viewModel.selectedPersonId = selectedPersonId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.fetchPersonDetails()
        viewModel.success = { [weak self] personDetails in
            DispatchQueue.main.async {
                self?.viewModel.selectedPerson = personDetails
                self?.setupTableView()
            }
        }
        
        viewModel.error = { [weak self] errorMessage in
            guard let self = self else { return }
            self.showErrorAlert(message: errorMessage)
        }
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(ImageCell.self, forCellReuseIdentifier: "BackdropCell")
        tableView.register(TitleCell.self, forCellReuseIdentifier: "TitleCell")
        tableView.register(TextCell.self, forCellReuseIdentifier: "OverviewCell")
        tableView.register(TextCell.self, forCellReuseIdentifier: "OverviewCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BackdropCell", for: indexPath) as? ImageCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            if let imageURL = viewModel.selectedPerson?.profileImageURL {
                cell.imageView?.loadImage(imageURL: imageURL.absoluteString)
            } else {
                cell.imageView?.image = UIImage(named: "placeholder")
            }
            
            if let imageView = cell.imageView {
                imageView.layer.cornerRadius = 10
                imageView.clipsToBounds = true
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(with: viewModel.selectedPerson?.name ?? "Unknown Person")
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell", for: indexPath) as? TextCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            let overviewText = viewModel.selectedPerson?.name != nil ?
            "\(viewModel.selectedPerson?.name ?? "Unknown Person") was born on \(viewModel.selectedPerson?.birthday ?? "unknown date") in \(viewModel.selectedPerson?.placeOfBirth ?? "unknown place")." :
            "No Biography Available"
            cell.configure(with: overviewText)
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell", for: indexPath) as? TextCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.textLabel?.textAlignment = .center
            cell.configure(with: viewModel.selectedPerson?.biography ?? "No Biography Available")
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            let screenWidth = UIScreen.main.bounds.width
            let aspectRatio: CGFloat = 0.75
            return screenWidth / aspectRatio
        default:
            return UITableView.automaticDimension
        }
    }
}
