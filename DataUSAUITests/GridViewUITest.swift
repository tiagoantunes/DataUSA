//
//  DetailsViewUITests.swift
//  DataUSAUITests
//
//  Created by Tiago Antunes on 13/10/2024.
//

import XCTest

final class DetailsViewUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testNavigation() throws {
        let collectionView = app.collectionViews.firstMatch.waitForExistence(timeout: 2)

        let firstCell = app.collectionViews.children(matching: .any).element(boundBy: 0)
        if firstCell.exists {
            firstCell.tap()
        }
    }

    func testNavBar() throws {
        let title = app.staticTexts["State"]
        let navBar = app.navigationBars.element

        XCTAssert(navBar.exists)
        XCTAssert(title.waitForExistence(timeout: 2))
    }
}
