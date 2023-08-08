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
    var movieObject: MovieModel?
    
    func getMovies(completionBlock: @escaping(Bool, MovieModel?)->()){
        
        MoviesRestClient().callSecureAPI(api: MOVIE_LIST, completion: { (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                    
                case .success(let responseData) :
                    print("movies ResponseData ---> \(responseData)")
                    
                    //                        let moviess = responseData["results"]
                    //                        print("moviess ---> \(moviess)")
                    //                        for m in 0..<moviess.count{
                    //                            let moviesL = moviess[m]
                    //                            print("moviesL ---> \(moviesL)")
                    //                            movieObject = MovieModel(page: responseData["page"].intValue, results: responseData["results"], totalPages: responseData["total_pages"].intValue, totalResults: responseData["total_results"].intValue)
                    //                           print("movieObject ---> \(responseData)")
                    //                        }
                    
                    do {
//                        let decoder = JSONDecoder()
//                        movieObject = try decoder.decode(MovieModel.self, from: responseData)
                        print("movieObject ---> \(movieObject)")
                    } catch {
                        // Handle decoding error
                    }
                    
                    completionBlock(true, movieObject)
                    
                case .failure(let error) :
                    SVProgressHUD.dismiss()
                    completionBlock(false, nil)
                    //                    onErrorHandling?(error)
                }
            }
        }, type: .GET, data: nil, isAbsoluteURL: true, isSilent: true)
    }
    
}
