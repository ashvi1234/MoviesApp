//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 09/08/23.
//

import UIKit
import SwiftUI
import SVProgressHUD

class MovieDetailsViewController: UIViewController {
    //MARK: - Variables
    var viewModel: MovieDetailsViewModel!
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
        navigationItem.title = "Movie Details"
        viewModel = MovieDetailsViewModel()
        viewModel.onError = { error in
            print("Error fetching movie details: \(error)")
        }
        SVProgressHUD.show()
        viewModel.getMovieDetails(movie_id: movieId) { success, movieDetailsResp in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.updateUI()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func updateUI() {
        guard let movieDetails = viewModel.movieDetails else {
            return
        }
        
        // Update your UI elements using the stored data
        let homePageUrl = URL(string: "\(IMAGE_BASE_URL)\(movieDetails.backdropPath )")
        self.homePgImgView.kf.setImage(with: homePageUrl)
        let mvPosterUrl = URL(string: "\(IMAGE_BASE_URL)\(movieDetails.posterPath )")
        self.mvPosterImgView.kf.setImage(with: mvPosterUrl)
        self.titleLbl.text = movieDetails.title
        self.ratingLbl.text = String(movieDetails.voteAverage)
        let rnTime = ""
        let runTime = rnTime.convertTime(timeSec: String(movieDetails.runtime))
        self.runtimeLbl.text = runTime
        let genreNames = movieDetails.genres.map { $0.name }.joined(separator: ", ")
        genreLbl.attributedText = "Genres: \(genreNames)".withBoldText(text: "\(genreNames)")
        self.lngLbl.text = movieDetails.originalLanguage == "en" ? "English" : "English"
        self.overviewLbl.text = movieDetails.overview
        let relDate = ""
        let releaseDate = relDate.convertDate(dateString: movieDetails.releaseDate, currentFormate: "yyyy-MM-dd", changeFormateTo: "dd-MM-yyyy")
        self.releaseDateLbl.text = releaseDate
        if (movieDetails.status == "Released") {
            self.statusLbl.textColor = UIColor.green
        }else{
            self.statusLbl.textColor = UIColor.red
        }
        self.statusLbl.text = movieDetails.status
        self.voteCountLbl.text = String(movieDetails.voteCount)
        let pCmpNames = movieDetails.productionCompanies.map { $0.name }.joined(separator: ", ")
        prodctnCompLbl.attributedText = "Production Companies: \(pCmpNames)".withBoldText(text: "\(pCmpNames)")
        let pCntryNames = movieDetails.productionCountries.map { $0.name }.joined(separator: ", ")
        prodctnCntryLbl.attributedText = "Production Contries: \(pCntryNames)".withBoldText(text: "\(pCntryNames)")
    }
}

