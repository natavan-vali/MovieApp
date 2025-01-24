import UIKit

class MoviesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let moviesVC = MoviesViewController()
        moviesVC.title = "Movies"
        navigationController.viewControllers = [moviesVC]
    }
}
