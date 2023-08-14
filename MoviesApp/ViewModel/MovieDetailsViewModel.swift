//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 09/08/23.
//

import Foundation
import UIKit
import SVProgressHUD
import Alamofire

class MovieDetailsViewModel {
    
    var movieDetails: MovieDetailsModel?
    var onDataUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func getMovieDetails(movie_id: Int, completionBlock: @escaping(Bool, MovieDetailsModel?)->()){
        SVProgressHUD.show()
        AF.request("\(MOVIE_DETAILS)\(movie_id)?api_key=\(API_KEY)").responseDecodable(of: MovieDetailsModel.self) { response in
            switch response.result {
            case .success(let movieDetails):
                self.movieDetails = movieDetails
                completionBlock(true, self.movieDetails)
                SVProgressHUD.dismiss()
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
}
