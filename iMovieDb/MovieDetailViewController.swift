//
//  MovieDetailViewController.swift
//  iMovieDb
//
//  Created by Thiện Huỳnh on 5/17/17.
//  Copyright © 2017 Thiện Huỳnh. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.11, green:0.12, blue:0.09, alpha:1.0)
        renderDetail(movie: self.movie!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setImage(posterURL: URL, backdropURL: URL) {
        getDataFromUrl(url: posterURL) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? posterURL.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.posterImage.image = UIImage(data: data)
            }
        }
        getDataFromUrl(url: backdropURL) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? backdropURL.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.backdropImage.image = UIImage(data: data)
            }
        }
    }
    
    func setMovie(movie: Movie) {
        self.movie = movie
    }
    
    func renderDetail(movie: Movie) {
        setImage(posterURL: URL(string: movie.getPosterPath())!, backdropURL: URL(string: movie.getBackdropPath())!)
        ratingLabel.text = "Rating: " + String(movie.voteAverage!)
        dateLabel.text = "Release: " + movie.releaseDate!
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }
}
