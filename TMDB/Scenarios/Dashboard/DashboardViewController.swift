//
//  DashboardViewController.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 18/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class DashboardViewController: UIViewController {

    private var viewModel: DashboardViewModel!
    
    @IBOutlet weak var dashboardCollectionView: UICollectionView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    private let searchController: UISearchController

    required init?(coder aDecoder: NSCoder) {
        searchController = UISearchController(searchResultsController: searchResultViewController())
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        title = "Movie Browser"
        dashboardCollectionView.dataSource = self
        dashboardCollectionView.prefetchDataSource = self
        dashboardCollectionView.delegate = self
        viewModel = DashboardViewModel(delegate: self)
        viewModel.fetchMovies()
    }
    
    
    @IBAction func sortAction(_ sender: UIBarButtonItem) {
        viewModel.toggleSort()
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
            cell.configure(with: viewModel.movie(at: indexPath.row))
        }
        return cell
    }
    
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movie(at: indexPath.row)
        let vc : MovieDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: MovieDetailsViewController.identifier) as! MovieDetailsViewController
        vc.movie = selectedMovie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DashboardViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchMovies()
        }
    }
    
}

extension DashboardViewController: DashboardViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            dashboardCollectionView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        dashboardCollectionView.reloadItems(at: indexPathsToReload)
    }
    
    func onFetchFailed(with reason: String) {
        self.showAlert(title: "Warning", message: reason, actionTitle: "Retry", callback: {
            self.viewModel.fetchMovies()
        })
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
