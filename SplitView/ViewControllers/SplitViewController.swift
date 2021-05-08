//
//  SplitViewController.swift
//  iPadSidebar
//
//  Created by James Rochabrun on 6/28/20.
//

import UIKit

final class SplitViewController: UISplitViewController {
    
    var tab = 0
    
    init() {
        super.init(style: .doubleColumn)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        preferredDisplayMode = .automatic
        preferredSplitBehavior = .automatic
        
        self.setViewController(SidebarViewController(), for: .primary)
        // Important to set the secondary view controller to a default, because starting iPad in portrait does need it before showing the sidebar
        self.setViewController( TabsViewModel.trips.primaryViewController, for: .secondary)
//        self.setViewController( UINavigationController(rootViewController: TabsViewModel.trips.primaryViewController), for: .secondary)
        self.setViewController(TabBarController(), for: .compact)
        
        super.delegate = self
    }
    
}

extension SplitViewController: UISplitViewControllerDelegate {
    
    func splitViewControllerDidExpand(_ svc: UISplitViewController) {
        print("Did expand")

        DispatchQueue.main.async {
            if let sbc = svc.viewController(for: .primary) as? SidebarViewController {
                sbc.selectedIndex = self.tab
            }
        }
        
    }
    
    func splitViewControllerDidCollapse(_ svc: UISplitViewController) {
        print("Did collapse")

        DispatchQueue.main.async {
            if let tbc = svc.viewController(for: .compact) as? UITabBarController {
                tbc.selectedIndex = self.tab
            }
        }
    }
}
