import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator {
    var tabBarController: UITabBarController
    
    private var moviesCoordinator: MoviesCoordinator
    private var tvSeriesCoordinator: TVSeriesCoordinator
    private var searchCoordinator: SearchCoordinator
    private var peopleCoordinator: PeopleCoordinator
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        
        let moviesNavVC = UINavigationController()
        self.moviesCoordinator = MoviesCoordinator(navigationController: moviesNavVC)
        
        let tvSeriesNavVC = UINavigationController()
        self.tvSeriesCoordinator = TVSeriesCoordinator(navigationController: tvSeriesNavVC)
        
        let searchNavVC = UINavigationController()
        self.searchCoordinator = SearchCoordinator(navigationController: searchNavVC)
        
        let peopleNavVC = UINavigationController()
        self.peopleCoordinator = PeopleCoordinator(navigationController: peopleNavVC)
    }
    
    func start() {
        moviesCoordinator.start()
        tvSeriesCoordinator.start()
        searchCoordinator.start()
        peopleCoordinator.start()
        
        tabBarController.viewControllers = [
            moviesCoordinator.navigationController,
            tvSeriesCoordinator.navigationController,
            searchCoordinator.navigationController,
            peopleCoordinator.navigationController
        ]
        
        setupTabBarItems()
    }
    
    private func setupTabBarItems() {
        tabBarController.viewControllers?[0].tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movies"), tag: 0)
        tabBarController.viewControllers?[1].tabBarItem = UITabBarItem(title: "TV Series", image: UIImage(named: "tv-series"), tag: 1)
        tabBarController.viewControllers?[2].tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 2)
        tabBarController.viewControllers?[3].tabBarItem = UITabBarItem(title: "Celebrities", image: UIImage(named: "people"), tag: 3)
    }
}
