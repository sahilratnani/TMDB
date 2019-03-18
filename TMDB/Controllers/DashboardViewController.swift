//
//  DashboardViewController.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 18/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    private var viewModel: PopularMoviesViewModel!
    
    @IBOutlet weak var dashboardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dashboardCollectionView.dataSource = self
        viewModel = PopularMoviesViewModel(delegate: self)
        viewModel.fetchPopularMovies()
    }
    
}

extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.identifier, for: indexPath) as? DashboardCollectionViewCell else {
            return UICollectionViewCell()
        }
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.moderator(at: indexPath.row))
        }
        return cell
    }
    
}

extension DashboardViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchPopularMovies()
        }
    }
    
}

extension DashboardViewController: PopularMoviesModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            dashboardCollectionView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        dashboardCollectionView.reloadItems(at: indexPathsToReload)
    }
    
    func onFetchFailed(with reason: String) {
        print("Failed to get data")
    }
}


private extension DashboardViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = dashboardCollectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
