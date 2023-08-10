//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 09/08/23.
//

import UIKit
import SwiftUI

class MovieDetailsViewController: UIViewController {
    //MARK: - Variables
    private var movieDetailsViewModel = MovieDetailsViewModel()
    private var movieDetails: MovieDetailsModel?
    @IBOutlet weak var homePgImgView: UIImageView!
    @IBOutlet weak var mvPosterImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var runtimeLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var lngLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var voteCountLbl: UILabel!
    @IBOutlet weak var prodctnCompLbl: UILabel!
    @IBOutlet weak var prodctnCntryLbl: UILabel!
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
                DispatchQueue.main.async {
                    self.movieDetails = movieDetailsResp
                    if let movie = self.movieDetails {
                        let homePageUrl = URL(string: "\(IMAGE_BASE_URL)\(movie.backdropPath )")
                        self.homePgImgView.kf.setImage(with: homePageUrl)
                        let mvPosterUrl = URL(string: "\(IMAGE_BASE_URL)\(movie.posterPath ?? "")")
                        self.mvPosterImgView.kf.setImage(with: mvPosterUrl)
                        self.titleLbl.text = movie.title
                        self.ratingLbl.text = String(movie.voteAverage)
                        var rnTime = ""
                        let runTime = rnTime.convertTime(timeSec: movie.runtime)
                        self.runtimeLbl.text = runTime
                        let genreNames = movie.genres.map { $0.name }
                        let allGenres = genreNames.joined(separator: ", ")
                        self.genreLbl.text = allGenres
                        self.lngLbl.text = movie.originalLanguage == "en" ? "English" : "English"
                        self.overviewLbl.text = movie.overview
                        var relDate = ""
                        let releaseDate = relDate.convertDate(dateString: movie.releaseDate, currentFormate: "yyyy-MM-dd", changeFormateTo: "dd-MM-yyyy")
                        self.releaseDateLbl.text = releaseDate
                        if (movie.status == "Released") {
                            self.statusLbl.textColor = UIColor.green
                        }else{
                            self.statusLbl.textColor = UIColor.red
                        }
                        self.statusLbl.text = movie.status
                        self.voteCountLbl.text = movie.voteCount
                        self.prodctnCompLbl.text = movie.productionCompany[0].name
                        self.prodctnCntryLbl.text = movie.productionContries[0].name
                    }
                }
            }else{
                print("no response")
            }
        }
    }
}
