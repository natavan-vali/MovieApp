import UIKit

class PeopleCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let peopleVC = PeopleViewController()
        peopleVC.title = "Celebrities"
        navigationController.viewControllers = [peopleVC]
    }
}
