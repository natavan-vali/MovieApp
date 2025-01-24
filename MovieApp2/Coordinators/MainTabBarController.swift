import UIKit

class MainTabBarController: UITabBarController {
    
    private var mainCoordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        
        mainCoordinator = MainCoordinator(tabBarController: self)
        mainCoordinator?.start()
    }
    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .gray
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        itemAppearance.selected.iconColor = .blue
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]

        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.layer.cornerRadius = 25
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.layer.shadowColor = UIColor.clear.cgColor
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 0
        tabBar.layer.shadowOpacity = 0
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
