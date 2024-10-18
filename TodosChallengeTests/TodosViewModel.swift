//
//  TodosViewModel.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/18/24.
//

import Foundation
import Factory
import Testing
@testable import TodosChallenge

@MainActor
struct TodosViewModelTests {
    
    
    @Test func sucessInitalTask() async {
        let todosDTO = [
            TodoDTO(userId: 3, serverId: 1, title: "Todo 1", completed: false),
            TodoDTO(userId: 3, serverId: 23, title: "Todo 2", completed: false),
            TodoDTO(userId: 3, serverId: 4, title: "Todo 3", completed: true),
            TodoDTO(userId: 3, serverId: 18, title: "Todo 3", completed: true),
        ]
        
        let todoProvider = TodoProviderStub(todos: todosDTO)
        Container.shared.todoProvider.register {
            todoProvider
        }
        let todosViewModel = TodosViewModel()
        switch todosViewModel.loadingState {
        case .error: Issue.record("We are expecting a loading state not an error")
        case .loaded: Issue.record("We are expecting a loading state not an error")
        case .loading: break
        }
        
        // When we call the intial task
        await todosViewModel.initalTask()
        
        // We expect a change to loaded state
        switch todosViewModel.loadingState {
        case .error: Issue.record( "We are expecting a loaded state not an error")
        case .loaded(let todos): #expect(todos.count == todosDTO.count)
        case .loading: Issue.record("We are expecting a loaded state not an loading")
        }
    }
    
    @Test func errorInitalTask() async {
        
        let error = TestError.testError
        let todoProvider = TodoProviderStub(error: error)
        Container.shared.todoProvider.register {
            todoProvider
        }
        let todosViewModel = TodosViewModel()
        switch todosViewModel.loadingState {
        case .error: Issue.record("We are expecting a loading state not an error")
        case .loaded: Issue.record("We are expecting a loading state not an error")
        case .loading: break
        }
        
        // When we call the intial task
        await todosViewModel.initalTask()
        
        // We expect a change to error state
        switch todosViewModel.loadingState {
        case .error: break
        case .loaded: Issue.record( "We are expecting an error state not an loaded")
        case .loading: Issue.record("We are expecting an error state not an loading")
        }
    }
    
    enum TestError: Error {
        case testError
    }
}
