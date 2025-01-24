import UIKit

class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        navigationController.viewControllers = [searchVC]
    }
}
