//
//  PeopleViewController1.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 26.11.24.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView
    private let viewModel = PeopleViewModel()
    
    override init(nibName: String?, bundle: Bundle?) {
        tableView = UITableView()
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Famous People"
        
        setupUI()
        bindViewModel()
        viewModel.fetchPopularPeople(page: 1)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageAndTitleCell.self, forCellReuseIdentifier: ImageAndTitleCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 150
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onPeopleUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { errorMessage in
            DispatchQueue.main.async {
                self.showErrorAlert(message: errorMessage)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageAndTitleCell.reuseIdentifier, for: indexPath) as! ImageAndTitleCell
        let person = viewModel.people[indexPath.row]
        
        cell.configure(with: person.name, imageURL: person.profileImageURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPersonId = viewModel.people[indexPath.row].id
        let detailsVC = PersonDetailsTableViewController(selectedPersonId)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
