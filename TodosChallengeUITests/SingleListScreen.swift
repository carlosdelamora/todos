//
//  SingleListScreen.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/18/24.
//

import XCTest

struct SingleListScreen: Screen {
    let app: XCUIApplication
    
    func collectionViewExists() -> Self {
        let singleList = app.collectionViews["SingleListView"]
        XCTAssertTrue(singleList.waitForExistence(timeout: 3))
        return self
    }
    
    func navigationBackButtonExists() -> Self {
        let navigationBackButton = app.navigationBars.buttons["Back"]
        XCTAssertTrue(navigationBackButton.exists)
        return self
    }
    
    func verifyAddTaskButtonExists() -> Self {
        let button = app.buttons["AddTask"]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        return self
    }
    
    func verifyMoreButtonExists() -> Self {
        let moreButton = app.navigationBars["Home"].images["ellipsis.circle"]
        XCTAssertTrue(moreButton.waitForExistence(timeout: 1))
        return self
    }
    
}
