//
//  SingleListUITest.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/18/24.
//

import XCTest
@testable import TodosChallenge

final class SingleListUITest: UserInterfaceTest {

    
    func testAddTaskButtonTapp() {
        let _ = HomeScreen(app: app)
            .navigateSingleList()
            .verifyAddTaskButtonExists()
            .verifyMoreButtonExists()
    }

}

