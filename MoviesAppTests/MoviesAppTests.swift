//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Ashwini Apurkar on 08/08/23.
//

import XCTest
@testable import MoviesApp

final class MoviesAppTests: XCTestCase {
    private var movieViewModel = MovieViewModel()
    private var movieDetailsViewModel = MovieDetailsViewModel()
    
    func testMoviesAPI(){
        let expectation = self.expectation(description: "movie_list_api")
        movieViewModel.getMovies { status, resp in
            XCTAssertNotNil(status)
            XCTAssertTrue(status)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testMovieDetailsAPI(){
        let expectation = self.expectation(description: "movie_details_api")
        movieDetailsViewModel.getMovieDetails(movie_id: 667538, completionBlock: { status, resp in
            XCTAssertNotNil(status)
            XCTAssertTrue(status)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
