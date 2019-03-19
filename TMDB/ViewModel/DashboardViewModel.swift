//
//  DashboardViewModel.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 18/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import Foundation

enum Sort: String {
    case byRating = "top_rated"
    case byPopularity = "popular"
}
protocol DashboardViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class DashboardViewModel {
private weak var delegate: DashboardViewModelDelegate?

private var movies: [Movies] = []
private var currentPage = 1
private var total = 0
private var isFetchInProgress = false
private var sortType: Sort = .byPopularity
    init(delegate: DashboardViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movies {
        return movies[index]
    }
    
    func toggleSort() {
        switch sortType {
        case .byPopularity:
            sortType = .byRating
        case .byRating:
            sortType = .byPopularity
        }
        movies = []
        currentPage = 1
        fetchMovies()
    }
    
    func fetchMovies() {
        guard !isFetchInProgress else {
            return
        }

        isFetchInProgress = true
        let url = "movie/\(sortType.rawValue)?api_key=\(Keys.apiKey)&page=\(currentPage)"
        ConnectionService.getReactiveServiceCall(type: .Get, url:url , payload: [:]) { result in
            print("callback received")
            switch result {
            case .success(let response):
                    let decodedResponse = try? JSONDecoder().decode(popularMoviesResponse.self, from: response)
                    DispatchQueue.main.async {
                        self.isFetchInProgress = false
                        if decodedResponse != nil {
                            self.currentPage += 1
                            self.total = decodedResponse!.totalResults
                            self.movies.append(contentsOf: decodedResponse!.movies)
                            // 3
                            if decodedResponse!.page > 1 {
                                let indexPathsToReload = self.calculateIndexPathsToReload(from: decodedResponse!.movies)
                                self.delegate?.onFetchCompleted(with: indexPathsToReload)
                            } else {
                                self.delegate?.onFetchCompleted(with: .none)
                            }
                        } else {
                            
                            guard let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: response) else {
                                self.delegate?.onFetchFailed(with: ErrorMessage.unknown)
                                return
                            }
                            self.delegate?.onFetchFailed(with: decodedResponse.statusMessage)
                        }
                        
                }
                
            case .failure(let error):
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: error.reason)
            }

            
        }
    }

    private func calculateIndexPathsToReload(from newMovies: [Movies]) -> [IndexPath] {
        let startIndex = movies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

}
