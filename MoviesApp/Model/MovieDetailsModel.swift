//
//  MovieDetailsModel.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 09/08/23.
//

import Foundation

struct MovieDetailsModel: Codable {
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String
    let releaseDate: String
    let voteAverage: Double
    let tagline: String
    let homepage: String
    let originalLanguage: String
    let originalTitle: String
    let popularity: String
    let revenue: String
    let runtime: String
    let status: String
    let voteCount: String
    let productionCompany: [ProductionCompany]
    let productionContries: [ProductionContries]
    let genres: [Genres]
}

struct ProductionCompany: Codable {
    let name: String
    let logoPath: String?
}

struct ProductionContries: Codable {
    let name: String
}

struct Genres: Codable{
    let name: String
}
