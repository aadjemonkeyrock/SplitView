//
//  TabsViewModel.swift
//  iPadSidebar
//
//  Created by James Rochabrun on 6/28/20.
//

import UIKit

// Abstract of a set of tabs in an app.


// MARK:- ViewModel
enum TabsViewModel: Int, CaseIterable {
    
    case trips
    case explore
    case notifications
    case profile
    case settings

    /// Return:- the tab bar icon using SF Symbols
    var image: UIImage? {        
        switch self {
        case .trips: return UIImage(systemName: "signpost.right.fill")
        case .explore: return UIImage(systemName: "safari.fill")
        case .notifications: return UIImage(systemName: "bell.fill")
        case .profile: return UIImage(systemName: "person.fill")
        case .settings: return UIImage(systemName: "gearshape.fill")
        }
    }
    /// Return:- the tab bar title
    var title: String {
        switch self {
        case .trips: return NSLocalizedString("Trips", comment: "")
        case .explore: return NSLocalizedString("Explore", comment: "")
        case .notifications: return NSLocalizedString("Notifications", comment: "")
        case .profile: return NSLocalizedString("Profile", comment: "")
        case .settings: return NSLocalizedString("Settings", comment: "")
        }
    }
    
    /// Return:-  the master/primary `topViewController`,  it instantiates a view controller using a convenient method for `UIStoryboards`.
    var primaryViewController: UIViewController  {
        switch self {
        case .trips: return TripsViewController()
        case .explore: return ExploreViewController()
        case .notifications: return NotificationsViewController()
        case .profile: return ProfileViewController()
        case .settings: return SettingsViewController()
        }
    }
}


class TripsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = TabsViewModel.trips.title
    }
}

class ExploreViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = TabsViewModel.explore.title
    }
}


class NotificationsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = TabsViewModel.notifications.title
    }
}

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = TabsViewModel.profile.title
    }
}

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = TabsViewModel.settings.title
    }
}
