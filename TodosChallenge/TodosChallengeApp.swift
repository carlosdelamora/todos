//
//  TodosChallengeApp.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//

import SwiftUI

@main
struct TodosChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TodosListsContainer(viewModel: TodosListsContainerViewModel(todos: TodosStub.todos))
            }
        }
    }
}
