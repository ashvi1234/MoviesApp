//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 09/08/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private var movieDetailsViewModel = MovieDetailsViewModel()
    private var movieDetails: [MovieDetailsModel] = []
    var movieTitle = ""
    var movieId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getMoviesDetails()
        }
    }
}

//MARK: - API call
extension MovieDetailsViewController {
    func getMoviesDetails() {
        movieDetailsViewModel.getMovieDetails(movie_id: movieId) { success, movieDetailsResp in
            if success {
                print("movieDetailsResp--->",movieDetailsResp)
                self.movieDetails = movieDetailsResp ?? []
            }else{
                print("no response")
            }
        }
    }
}
