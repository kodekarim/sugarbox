//
//  HomeTabViewController.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import UIKit

class HomeTabViewController: UIViewController {
    
    weak var mainCoordinator :MainCoordinator?
    var viewModel :HomeViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Sections, Contents>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // setting up collection view
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)

        // registring cells
        collectionView.register(FeatureCell.self, forCellWithReuseIdentifier: FeatureCell.reuseIdentifier)
        collectionView.register(SectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: ContentCell.reuseIdentifier)

        //setting data source
        createDataSource()
    }

    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with app: Contents, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }

        cell.configure(with: app)
        return cell
    }

    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, Contents>(collectionView: collectionView) { collectionView, indexPath, app in
            
            let widgetType = self.viewModel.dataModel?.sections?[indexPath.section].designSlug
            let section = SectionType.init(rawValue: widgetType ?? "")
            
            switch section {
            case .CarousalWidget:
                return self.configure(FeatureCell.self, with: app, for: indexPath)
            case .OTTWidget:
                return self.configure(ContentCell.self, with: app, for: indexPath)
            default:
                return UICollectionViewCell()
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCell.reuseIdentifier, for: indexPath) as? SectionHeaderCell else {
                return nil
            }

            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else {  return nil }
            if section.title?.isEmpty == true {
                return nil
            }

            sectionHeader.title.text = section.title
            return sectionHeader
        }
    }

    func reloadCollectionData() {
        guard let dataModel = viewModel.dataModel else {
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Contents>()
        snapshot.appendSections(dataModel.sections ?? [])

        for section in dataModel.sections ?? [] {
            snapshot.appendItems(section.contents ?? [], toSection: section)
        }

        dataSource?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            guard let sectionData = self.viewModel.dataModel?.sections?[sectionIndex] else {
                return self.emptySection()
            }
            
            let widgetType = sectionData.designSlug
            let section = SectionType.init(rawValue: widgetType ?? "")

            switch section {
            case .CarousalWidget:
                return self.createFeaturedSection(using: sectionData)
            case .OTTWidget:
                return self.createContentSection(using: sectionData)
            default:
                return self.emptySection()
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    
    func createFeaturedSection(using section: Sections) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let isPortrait = isOrientationPortrait()
        let layoutWidth:CGFloat = isPortrait ? 0.93 : 0.5
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(layoutWidth), heightDimension: .estimated(300))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
    }
    
    func createContentSection(using section: Sections) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let isPortrait = isOrientationPortrait()
        let layoutWidth:CGFloat = isPortrait ? 0.6 : 0.3
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(layoutWidth), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let isPortrait = isOrientationPortrait()
        let layoutWidth:CGFloat = isPortrait ? 0.93 : 0.5
        
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(layoutWidth), heightDimension: .estimated(40))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return layoutSectionHeader
    }
    
    func emptySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(0), heightDimension: .estimated(0))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(0), heightDimension: .estimated(0))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return layoutSection
    }
    
    func isOrientationPortrait() -> Bool {
        let isVertical = traitCollection.verticalSizeClass
        if isVertical == .regular {
            return true
        }else {
            return false
        }
    }

}

extension HomeTabViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let contentData = viewModel.dataModel?.sections?[indexPath.section].contents?[indexPath.row] {
            mainCoordinator?.moveToDetails(data: contentData)
        }

    }
}

extension HomeTabViewController : HomeViewModelDelegates {
    func reloadData() {
        reloadCollectionData()
    }
}

