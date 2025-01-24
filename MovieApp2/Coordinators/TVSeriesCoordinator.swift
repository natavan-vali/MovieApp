import UIKit

class TVSeriesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tvSeriesVC = TVSeriesViewController()
        tvSeriesVC.title = "TV Series"
        navigationController.viewControllers = [tvSeriesVC]
    }
}
