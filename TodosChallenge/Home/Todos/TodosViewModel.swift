//
//  TodoListViewModel.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//

import Combine
import SwiftUI
import Factory

@MainActor
@Observable
class TodosViewModel {
    
    //MARK: - API
    
    private(set) var loadingState: LoadingState<[Todo]> = .loading
    
    func initalTask() async {
        loadingState = .loading
        do {
            let todoDTOs = try await todoProvider.todos()
            let todos = todoDTOs.map( { Todo(dto: $0)})
            loadingState = .loaded(todos)
        } catch {
            loadingState = .error(error)
        }
    }
    
    //MARK: - Constants
    
    //MARK: - Variables
    
    @ObservationIgnored
    @Injected(\.todoProvider) var todoProvider
}

enum LoadingState<T> {
    case loading
    case loaded(T)
    case error(Error)
}
  
extension Container {
    
    var todoProvider: Factory<TodoProviding> {
        self { TodoProvider() }
    }
}


