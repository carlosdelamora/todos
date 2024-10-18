//
//  HomeScreen.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/18/24.
//

import XCTest

protocol Screen {
    var app: XCUIApplication { get }
}

struct HomeScreen: Screen {
    let app: XCUIApplication
    
    private enum Identifiers {
        static let listsCollection = "Lists collection"
    }
    
    func navigateSingleList() -> SingleListScreen {
        let collectonView = app.collectionViews["Lists collection"]
        XCTAssertTrue(collectonView.waitForExistence(timeout: 1))
        let button = collectonView.cells.firstMatch
        XCTAssertTrue(button.waitForExistence(timeout: 1))
        button.tap()
        return SingleListScreen(app: app)
    }
}

