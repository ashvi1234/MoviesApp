//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 08/08/23.
//

import Foundation
import UIKit
import SVProgressHUD
import Alamofire

class MovieViewModel {
    
    var movieList: [Results] = [] // Store decoded Results objects here
    var onDataUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func getMovies(completionBlock: @escaping(Bool, [Results]?)->()) {
        SVProgressHUD.show()
        AF.request(MOVIE_LIST).responseDecodable(of: MovieModel.self) { response in
            switch response.result {
            case .success(let movieModel):
                self.movieList = movieModel.results.sorted(by: { $0.voteAverage > $1.voteAverage }).prefix(10).map { $0 }
                completionBlock(true, self.movieList)
                SVProgressHUD.dismiss()
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
}
