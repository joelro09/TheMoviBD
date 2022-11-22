//
//  ApiConstants.swift
//  MoviDB
//
//  Created by Phinder 2022 on 20/11/22.
//

import Foundation

class ApiConstants {
    
   static let login = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(apiKey)"
    
   static let apiKey = "a30597f70d90c21fb51f507c0df2ccf4"
    
   static let tokenBase = "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"

    static let listMovies = "https://api.themoviedb.org/3/movie/{movie_id}/lists?api_key=\(apiKey)&language=en-US&page=1"
    
    
    
}
