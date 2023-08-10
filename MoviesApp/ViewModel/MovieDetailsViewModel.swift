//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 09/08/23.
//

import Foundation
import UIKit
import SVProgressHUD

class MovieDetailsViewModel {
    
    var movieDetailsObject: MovieDetailsModel?
    
    func getMovieDetails(movie_id: Int, completionBlock: @escaping(Bool, MovieDetailsModel?)->()){
        
        MoviesRestClient().callSecureAPI(api: "\(MOVIE_DETAILS)\(movie_id)?api_key=\(API_KEY)", completion: { (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let responseData) :
                    let genres = responseData["genres"]
                    let productionCompanies = responseData["production_companies"]
                    let productionCountries = responseData["production_countries"]
                    for g in 0..<genres.count{
                        let gen = genres[g]
                        
                        for comp in 0..<productionCompanies.count{
                            let productionCompany = productionCompanies[comp]
                            
                            for contry in 0..<productionCountries.count{
                                let productionCountry = productionCountries[contry]
                                
                                movieDetailsObject = MovieDetailsModel(title: responseData["title"].stringValue, overview: responseData["overview"].stringValue, posterPath: responseData["poster_path"].stringValue, backdropPath: responseData["backdrop_path"].stringValue, releaseDate: responseData["release_date"].stringValue, voteAverage: responseData["vote_average"].doubleValue, tagline: responseData["tagline"].stringValue, homepage: responseData["homepage"].stringValue, originalLanguage: responseData["original_language"].stringValue, originalTitle: responseData["original_title"].stringValue, popularity: responseData["popularity"].stringValue, revenue: responseData["revenue"].stringValue, runtime: responseData["runtime"].stringValue, status: responseData["status"].stringValue, voteCount: responseData["vote_count"].stringValue, productionCompany: [ProductionCompany(name: productionCompany["name"].stringValue, logoPath: productionCompany["logo_path"].stringValue)], productionContries: [ProductionContries(name: productionCountry["name"].stringValue)], genres: [Genres(name: gen["name"].stringValue)])
                            }
                            
                        }
                    }
                    completionBlock(true, self.movieDetailsObject)
                    
                case .failure(let error) :
                    SVProgressHUD.dismiss()
                    completionBlock(false, nil)
                    onErrorHandling?(error)
                }
            }
        }, type: .GET, data: nil, isAbsoluteURL: true, isSilent: true)
    }
    
}
