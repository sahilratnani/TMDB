//
//  Movies.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 18/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    
    
    let voteCount: Int
    let id: Int
    let video: Bool
    let voteAverage: Float
    let title: String
    let popularity: Float
    let posterPath: String
    let backdropPath: String
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let adult: Bool
    let overview: String
    let releaseDate: String
    
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id
        case video
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case adult
        case overView = "overview"
        case releaseDate = "release_date"
        
    }
    
    init(voteCount: Int, id: Int, video: Bool, voteAverage: Float, title: String, popularity: Float, posterPath: String, backdropPath: String, originalLanguage: String, originalTitle: String, genreIds: [Int], adult: Bool, overview: String, releaseDate: String) {
        self.voteCount  =   voteCount
        self.id         = id
        self.video      = video
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIds = genreIds
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        let id = try container.decode(Int.self, forKey: .id)
        let video = try container.decode(Bool.self, forKey: .video)
        let voteAverage = try container.decode(Float.self, forKey: .voteAverage)
        let title = try container.decode(String.self, forKey: .title)
        let popularity = try container.decode(Float.self, forKey: .popularity)
        let posterPath = try container.decode(String.self, forKey: .posterPath)
        let backdropPath = try container.decode(String.self, forKey: .backdropPath)
        let originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        let originalTitle = try container.decode(String.self, forKey: .originalTitle)
        let genreIds = try container.decode([Int].self, forKey: .genreIds)
        let adult = try container.decode(Bool.self, forKey: .adult)
        let overview = try container.decode(String.self, forKey: .overView)
        let releaseDate = try container.decode(String.self, forKey: .releaseDate)
        
        self.init(voteCount: voteCount, id: id, video: video, voteAverage: voteAverage, title: title, popularity: popularity, posterPath: posterPath,backdropPath: backdropPath, originalLanguage: originalLanguage, originalTitle: originalTitle, genreIds: genreIds, adult: adult, overview: overview, releaseDate: releaseDate)
    }
}
