//
//  TabBarController.swift
//  iPadSidebar
//
//  Created by James Rochabrun on 6/28/20.
//

import UIKit

// MARK:- TabBarController
final class TabBarController: UITabBarController {
    /// 1 - Set view Controllers using `TabsViewModel`
    /// 2 - This iteration will create a master view controller embedded in a navigation controller for each tab.
    override func viewDidLoad() {
        super.viewDidLoad()

        let insets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

        viewControllers = TabsViewModel.allCases.map {
            let nc = UINavigationController(rootViewController: $0.primaryViewController)
            nc.tabBarItem.image = $0.image?.withAlignmentRectInsets(insets)
            nc.tabBarItem.tag = $0.rawValue
            return nc
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let splitViewController = self.splitViewController as? SplitViewController else { return }
        
        // keep track of the current tab, to make sure we can persist the current view on size changes
        splitViewController.tab = item.tag
    }
    

}

