//
//  PopularMoviesViewModel.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 18/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import Foundation

protocol PopularMoviesModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class PopularMoviesViewModel {
private weak var delegate: PopularMoviesModelDelegate?

private var movies: [Movies] = []
private var currentPage = 1
private var total = 0
private var isFetchInProgress = false

    init(delegate: PopularMoviesModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return movies.count
    }
    
    func moderator(at index: Int) -> Movies {
        return movies[index]
    }
    
    func fetchPopularMovies() {
        // 1
        guard !isFetchInProgress else {
            return
        }
        
        // 2
        isFetchInProgress = true
        let url = "movie/popular?api_key=722e727142324b59fe7a03f5206658a1&language=en-US&page=\(currentPage)"
        ConnectionService.getReactiveServiceCall(type: .Get, url:url , payload: [:]) { (response) in
            print("callback received")
        
            let decodedResponse = try? JSONDecoder().decode(popularMoviesResponse.self, from: response)
            
                DispatchQueue.main.async {
                    // 1
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    // 2
                    self.total = decodedResponse!.totalPages
                    self.movies.append(contentsOf: decodedResponse!.movies)
                    
                    // 3
                    if decodedResponse!.page > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: decodedResponse!.movies)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            
        }
    }

    private func calculateIndexPathsToReload(from newMovies: [Movies]) -> [IndexPath] {
        let startIndex = movies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

}
