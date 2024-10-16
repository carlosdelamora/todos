//
//  SingleListViewModel.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/15/24.
//

import Observation
import Foundation
import SwiftUI

@MainActor
@Observable
class SingleTodoViewModel {
    //MARK: - API
    
    var todos: [Todo] {
        uncompletedTodos + completedTodos
    }
    
    var newTodoTitle: String = ""
    var isAddingInlineTodo = false
    var isEditingTodoId: UUID?
    let bottomId = "bottomId"
    
    func bindTo(todo: Todo) -> Binding<Todo> {
        let isCompleted = todo.isCompleted
        if isCompleted {
            guard let index = completedTodos.firstIndex(where: { $0.id == todo.id }) else {
                return .constant(todo)
            }
//            @Binding var todo = completedTodos[index]
//            return $todo
            return Binding<Todo>(get: {
                self.completedTodos[index]
            }, set: {
                print("We did set the binding")
                self.completedTodos[index] = $0
            })
        } else {
            guard let index = uncompletedTodos.firstIndex(where: { $0.id == todo.id }) else {
                return .constant(todo)
            }
            //uncompletedTodos[index].isCompleted.toggle()
            return Binding<Todo>(get: {
                self.uncompletedTodos[index]
            }, set: {
                print("We did set the binding uncompleted")
                self.uncompletedTodos[index] = $0
            })
        }
    }
    
    init(todos: [Todo]) {
        // It should come sorted from BE
        uncompletedTodos = todos.filter({ !$0.isCompleted })
        completedTodos = todos.filter({ $0.isCompleted })
        //self.todos = uncompletedTodos + completedTodos
    }
    
    func didTappCheckButton(todo: Todo) {
        let isCompleted = todo.isCompleted
        if isCompleted {
            guard let index = completedTodos.firstIndex(where: { $0.id == todo.id }) else { return }
            completedTodos[index].isCompleted.toggle()
            let todo = completedTodos.remove(at: index)
            // The todo is now uncompleted and we place it at the end of the uncompleted list
            uncompletedTodos.append(todo)
        } else {
            guard let index = uncompletedTodos.firstIndex(where: { $0.id == todo.id }) else {
                return
            }
            uncompletedTodos[index].isCompleted.toggle()
            let todo = uncompletedTodos.remove(at: index)
            // The todo now is completed and we add it at the top of the list
            completedTodos.insert(todo, at: 0)
        }
    }
    
    func addTodoButtonTapped() {
        isAddingInlineTodo = true
    }
    
    func onNewTodoSubmit() {
        isAddingInlineTodo = false
        createInlineTodo()
    }
    
    
    //MARK: - Variables
    
    private var uncompletedTodos: [Todo]
    private var completedTodos: [Todo]
    
    //MARK: - Implementation
    
    private func createInlineTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = Todo(serverId: nil, id: UUID(), title: newTodoTitle, isCompleted: false)
        uncompletedTodos.append(newTodo)
        // Clear the textfield for the new inline todo
        newTodoTitle = ""
    }
    
}
