//
//  UserInterfaceTest.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/18/24.
//

import XCTest

class UserInterfaceTest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        let screenShot = XCUIScreen.main.screenshot()
        let attachement = XCTAttachment(screenshot: screenShot)
        add(attachement)
    }
}
