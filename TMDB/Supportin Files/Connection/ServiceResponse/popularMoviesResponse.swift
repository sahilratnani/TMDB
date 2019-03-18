//
//  popularMoviesResponse.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 18/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import Foundation

struct popularMoviesResponse: Decodable {
    let movies: [Movies]
    let totalResults: Int
    let totalPages: Int
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case page
    }
}
