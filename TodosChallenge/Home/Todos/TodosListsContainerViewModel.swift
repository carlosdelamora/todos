//
//  TodoListViewModel.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//

import Combine
import SwiftUI

@Observable
class TodosViewModel {
    
    //MARK: - API
    private(set) var loadingState: LoadingState<TodosListsContainerViewModel> = .loading
    
    //MARK: - Constants
    
    //MARK: - Variables
    
    
}

enum LoadingState<T> {
    case loading
    case loaded(T)
    case error(Error)
}

struct TodoSection: Identifiable {
    var id: String {
        title
    }
    var title: String
    var todos: [Todo]
}

@MainActor
@Observable
class TodosListsContainerViewModel {
    
    //MARK: - API
    
    var editMode: EditMode = .inactive
    var uncompletedSectionContentViewModel: EditableTodoSectionContentViewModel
    var completedSectionContentViewModel: EditableTodoSectionContentViewModel
    init(todos: [Todo]) {
        let completedTodos = todos.filter(\.isCompleted)
        let uncompletedTodos = todos.filter( { !$0.isCompleted })
        uncompletedSectionContentViewModel = EditableTodoSectionContentViewModel(todos: uncompletedTodos)
        completedSectionContentViewModel = EditableTodoSectionContentViewModel(todos: completedTodos)
    }
    
    func move(todos: [Todo], from: inout [Todo], to: inout [Todo], destinationIndex: Int) {
        for todo in todos {
            todo.isCompleted.toggle()
            guard let index = from.firstIndex(where: { $0.id == todo.id }) else { continue }
            to.insert(todo, at: destinationIndex)
            from.remove(at: index)
        }
    }
    
    func addTodoButtonTapped() {
        uncompletedSectionContentViewModel.createInlineTodo()
        uncompletedSectionContentViewModel.isAddingInlineTodo = true
    }
    
    
    //MARK: - Constants
    
    //MARK: - Variables
    
}
    
    
