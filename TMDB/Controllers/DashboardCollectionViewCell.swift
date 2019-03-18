//
//  DashboardCollectionViewCell.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 19/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import UIKit
import SDWebImage
class DashboardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "dashboardCVCell"
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var moviewTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configure(with movie: Movies?) {
        if let movie = movie {
            let imageUrl = URL.init(string: URLS.imageBaseURL + movie.posterPath)
            
            let imageView = UIImageView()
            imageView.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "placeHolderImage") , options: []) { (image, error, cacheType, url) in
               
                        self.moviePosterImageView.image = imageView.image
                
            }
            moviewTitleLabel.text = movie.title
            ratingLabel.text = "\(movie.voteAverage)"
        } else {
            
        }
    }
}
