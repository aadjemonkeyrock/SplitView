//
//  SidebarViewcontroller.swift
//  iPadSidebar
//
//  Created by James Rochabrun on 6/28/20.
//

import UIKit

final class SidebarViewController: UIViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    private enum SidebarSection: Int {
        case library
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SidebarSection, TabsViewModel>!

    public var selectedIndex: Int = 0 {
        didSet {
            // Set the navigation
            collectionView.selectItem(at: IndexPath(row: self.selectedIndex, section: 0),
                                      animated: false,
                                      scrollPosition: UICollectionView.ScrollPosition.centeredVertically)
            
            // Set the correct view
            if  let t = TabsViewModel.init(rawValue: self.selectedIndex) {
                let nc = UINavigationController(rootViewController: t.primaryViewController)
                splitViewController?.showDetailViewController(nc, sender: self)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureCollectionView()
        configureDataSource()
        
        applyInitialSnapshot()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Going Walkabout"
        
        self.selectedIndex = 0
    }

    private func configureCollectionViewLayout() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .systemGroupedBackground
    }
}


extension SidebarViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout() { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            var configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
            configuration.showsSeparators = false
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            return section
        }
        return layout
    }
}

extension SidebarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tab = dataSource.itemIdentifier(for: indexPath),
              let splitViewController = self.splitViewController as? SplitViewController
              else { return }
        
        if (indexPath.section == 0) {
            // Remember the tab, so we can sync tabs when going to compact
            splitViewController.tab = indexPath.row
        }
        
        let nc = UINavigationController(rootViewController: tab.primaryViewController)
        splitViewController.showDetailViewController(nc, sender: self)
    }
}

extension SidebarViewController {
    private func configureDataSource() {
        let rowRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, TabsViewModel> {
            (cell, indexPath, item) in
            
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.image = item.image
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<SidebarSection, TabsViewModel>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell in
                return collectionView.dequeueConfiguredReusableCell(using: rowRegistration, for: indexPath, item: item)
        }
    }
    
    private func librarySnapshot() -> NSDiffableDataSourceSectionSnapshot<TabsViewModel> {
        var snapshot = NSDiffableDataSourceSectionSnapshot<TabsViewModel>()
        snapshot.append(TabsViewModel.allCases)

        return snapshot
    }
    
    private func applyInitialSnapshot() {
        dataSource.apply(librarySnapshot(), to: .library, animatingDifferences: false)
    }

}
