//
//  HelperMethods.swift
//  iMovieDb
//
//  Created by Thiện Huỳnh on 5/17/17.
//  Copyright © 2017 Thiện Huỳnh. All rights reserved.
//

import Foundation

func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
    URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        completion(data, response, error)
        }.resume()
}
