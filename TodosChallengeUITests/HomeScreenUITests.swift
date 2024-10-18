//
//  HomeScreenUITests.swift
//  TodosChallengeUITests
//
//  Created by Carlos De la mora on 10/18/24.
//

import XCTest
@testable import TodosChallenge

final class HomeScreenUITests: UserInterfaceTest {

    
    func testHomeNavigation() {
        let _ = HomeScreen(app: app).navigateSingleList()
    }

}
