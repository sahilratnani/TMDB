//
//  MovieDetailsViewController.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 19/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    static let identifier = "movieDetails"
    
    @IBOutlet weak var movieBackdropImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    var movie : Movies!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        
        title = "TMDB"
        
        if movie != nil {
            
            var imageUrl = URL.init(string: URLS.imageBaseURL + movie.posterPath)
            let imageView = UIImageView()
            imageView.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "placeHolderImage") , options: []) { (image, error, cacheType, url) in
                self.moviePosterImageView.image = imageView.image
            }
            
            imageUrl = URL.init(string: URLS.imageBaseURL + movie.backdropPath)
            imageView.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "placeHolderImage") , options: []) { (image, error, cacheType, url) in
                self.movieBackdropImageView.image = imageView.image
            }
            
            self.movieTitleLabel.text = movie.originalTitle
            self.releaseDateLabel.text = movie.releaseDate
            self.ratingLabel.text = "\(movie.voteAverage)"
            self.votesLabel.text = "\(movie.voteCount) Votes"
            self.overviewLabel.text = movie.overview
        }
    }

}
