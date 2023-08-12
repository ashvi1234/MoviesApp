//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Ashwini Apurkar on 08/08/23.
//

import XCTest

final class MoviesAppUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testIsImagesViewNil() {
        let imageView = app.images["TableViewController.ImageCell.ImageView"]
        let posterImage = app.images["poster_image"]
        let backPathImage = app.images["backpath_image"]
        XCTAssertNotNil(imageView)
        XCTAssertNotNil(posterImage)
        XCTAssertNotNil(backPathImage)
    }
    
    func testIsLabelsViewNil() {
        let title = app.staticTexts["title"].exists
        XCTAssertNotNil(title)
        let rating = app.staticTexts["rating"].exists
        XCTAssertNotNil(rating)
        let runtime = app.staticTexts["runtime"].exists
        XCTAssertNotNil(runtime)
        let genre = app.staticTexts["genre"].exists
        XCTAssertNotNil(genre)
        let language = app.staticTexts["language"].exists
        XCTAssertNotNil(language)
        let overview = app.staticTexts["overview"].exists
        XCTAssertNotNil(overview)
        let release_date = app.staticTexts["release_date"].exists
        XCTAssertNotNil(release_date)
        let status = app.staticTexts["status"].exists
        XCTAssertNotNil(status)
        let vote = app.staticTexts["vote"].exists
        XCTAssertNotNil(vote)
        let company = app.staticTexts["company"].exists
        XCTAssertNotNil(company)
        let country = app.staticTexts["country"].exists
        XCTAssertNotNil(country)
    }
  
}

