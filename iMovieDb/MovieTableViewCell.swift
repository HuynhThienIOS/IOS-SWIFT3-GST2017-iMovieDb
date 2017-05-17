//
//  MovieTableViewCell.swift
//  iMovieDb
//
//  Created by Thiện Huỳnh on 5/13/17.
//  Copyright © 2017 Thiện Huỳnh. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(red:0.11, green:0.12, blue:0.09, alpha:1.0)
        backgroundView?.backgroundColor = UIColor(red:0.15, green:0.16, blue:0.13, alpha:1.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setImage(url: URL){
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.posterImage.image = UIImage(data: data)
            }
        }
    }
    
    func renderMovieCell(movie: Movie){
        setImage(url: URL(string: movie.getPosterPath())!)
        ratingLabel.text = "Rating: " + String(movie.voteAverage!)
        yearLabel.text = "Release: " + movie.releaseDate!
        titleLabel.text = movie.title
    }
}
