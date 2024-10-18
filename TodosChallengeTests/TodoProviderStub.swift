//
//  TodoProviderStub.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/18/24.
//

@testable import TodosChallenge

struct TodoProviderStub: TodoProviding {
    
    var todos: [TodoDTO] = []
    var error: (any Error)?
    
    init(todos: [TodoDTO]) {
        self.todos = todos
    }
    
    init(error: some Error) {
        self.error = error
    }
    func todos() async throws -> [TodoDTO] {
        guard let error else { return todos }
        throw error
    }

}
