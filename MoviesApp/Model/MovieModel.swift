//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Ashwini Apurkar on 08/08/23.
//

import Foundation

struct MovieModel: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    let backdropPath: String
    let voteAverage: Double
    let voteCount: Int
}

struct MovieResponse: Codable {
    let results: [MovieModel]
}
