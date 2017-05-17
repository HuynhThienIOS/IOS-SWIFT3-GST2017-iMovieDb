//
//  Movie.swift
//  iMovieDb
//
//  Created by Thiện Huỳnh on 5/13/17.
//  Copyright © 2017 Thiện Huỳnh. All rights reserved.
//

import Foundation

let APIKey = "bf144d99969c3e174c395faf9782475d"
let APIURLPrefix = "https://api.themoviedb.org/3"
let imageURLPrefix = "https://image.tmdb.org/t/p"

class Movie {
    
    var id: Int
    var title: String
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var voteAverage: Float?
    var releaseDate: String?
    
    init(json: [String:Any]) {
        id = json["id"] as! Int
        title = json["original_title"] as! String
        overview = json["overview"] as? String
        posterPath = json["poster_path"] as? String
        backdropPath = json["backdrop_path"] as? String
        voteAverage = json["vote_average"] as? Float
        releaseDate = json["release_date"] as? String
    }
    
    func getPosterPath() -> String {
        if posterPath == nil {
            return "https://www.themoviedb.org/assets/static_cache/41bdcf10bbf6f84c0fc73f27b2180b95/images/v4/logos/91x81.png"
        } else {
            return "\(imageURLPrefix)/w185\(posterPath!)"
        }
    }
}

class MovieCollection {
    var movies = [Movie]()
    
    fileprivate var urlFormat = "\(APIURLPrefix)/movie/now_playing?api_key=\(APIKey)&page="
    
    init() {}
    
    func fetch(page: Int) -> [Movie]{
        let url = NSURL(string: urlFormat + String(page))
        let urlRequest = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 3.0)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, respone, error) in
            if (error != nil) {
                print(error!)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    var jsonData = [Any]()
                    jsonData = json["results"] as! [Any]
                    for movie in jsonData {
                        self.movies.append(Movie(json: movie as! [String : Any]))
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
        sleep(3)  // uncomment may risk the movies array
        return movies
    }
    
}
