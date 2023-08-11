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
    
//    func testIsLabelsViewNil() {
//        let title = app.staticTexts["title"]
//        let rating = app.staticTexts["rating"]
//        let runtime = app.staticTexts["runtime"]
//        let genre = app.staticTexts["genre"]
//        let language = app.staticTexts["language"]
//        let overview = app.staticTexts["overview"]
//        let release_date = app.staticTexts["release_date"]
//        let status = app.staticTexts["status"]
//        let vote = app.staticTexts["vote"]
//        let company = app.staticTexts["company"]
//        let country = app.staticTexts["country"]
//        XCTAssertEqual(title.label, "title text")
//        XCTAssertEqual(rating.label, "rating text")
//        XCTAssertEqual(runtime.label, "runtime text")
//        XCTAssertEqual(genre.label, "genre text")
//        XCTAssertEqual(language.label, "language text")
//        XCTAssertEqual(overview.label, "overview text")
//        XCTAssertEqual(release_date.label, "release_date text")
//        XCTAssertEqual(status.label, "status text")
//        XCTAssertEqual(vote.label, "vote text")
//        XCTAssertEqual(company.label, "company text")
//        XCTAssertEqual(country.label, "country text")
//    }
}

