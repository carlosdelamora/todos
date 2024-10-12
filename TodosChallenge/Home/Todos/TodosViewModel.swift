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
    private(set) var loadingState: LoadingState<TodoManager> = .loading
    
    //MARK: - Constants
    
    //MARK: - Variables
    
    
}

enum LoadingState<T> {
    case loading
    case loaded(T)
    case error(Error)
}

@Observable
class TodoManager {
    
    //MARK: - API
    
    var todos: [Todo]
    
    init(todos: [Todo]) {
        self.todos = todos
    }
    
    var isEmpty: Bool {
        todos.isEmpty
    }
    
    func delete(_ todoIds: IndexSet) {
        todos.remove(atOffsets: todoIds)
    }
    
    //MARK: - Constants
    
    //MARK: - Variables
    
}
    
    
