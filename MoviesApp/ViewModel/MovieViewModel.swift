//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 08/08/23.
//

import Foundation
import UIKit
import SVProgressHUD

class MovieViewModel {
    
    var movieObject: [MovieModel]? = []
    
    func getMovies(completionBlock: @escaping(Bool, [MovieModel]?)->()){
        
        MoviesRestClient().callSecureAPI(api: MOVIE_LIST, completion: { (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                    
                case .success(let responseData) :
                    
                    let moviess = responseData["results"]
                    for m in 0..<moviess.count{
                        let moviesL = moviess[m]
                        let movieObjects = [MovieModel(id: moviesL["id"].intValue, title: moviesL["title"].stringValue, overview: moviesL["overview"].stringValue, releaseDate: moviesL["release_date"].stringValue, posterPath: moviesL["poster_path"].stringValue, backdropPath: moviesL["backdrop_path"].stringValue, voteAverage: moviesL["vote_average"].doubleValue, voteCount: moviesL["vote_count"].intValue)]
                        movieObject?.append(contentsOf: movieObjects)
                    }
                    completionBlock(true, self.movieObject)
                    
                case .failure(let error) :
                    SVProgressHUD.dismiss()
                    completionBlock(false, nil)
                    onErrorHandling?(error)
                }
            }
        }, type: .GET, data: nil, isAbsoluteURL: true, isSilent: true)
    }
    
}
