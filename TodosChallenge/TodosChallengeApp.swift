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
            SingleTodoListView(viewModel: SingleTodoViewModel(todos: TodosStub.todos))
//            NavigationStack {
//                TodosListsContainer(viewModel: TodosListsContainerViewModel(todos: TodosStub.todos))
//            }
        }
    }
}
