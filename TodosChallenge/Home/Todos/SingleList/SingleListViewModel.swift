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
        switch currentFilter {
        case .none: uncompletedTodos + completedTodos
        case .uncompleted: completedTodos
        case .completed: uncompletedTodos
        }
    }
    
    var newTodoTitle: String = ""
    var isAddingNewTodo = false
    let bottomId = "bottomId"
    
    var hideCompletedLabelConfig: SystemImageLabelConfig {
        let title = isCompletedFiltered ? "Show completed" : "Hide completed"
        let systemName = isCompletedFiltered ? "eye.slash" : "eye.fill"
        return SystemImageLabelConfig(title: title, systemName: systemName)
    }
    
    var hideUncompletedLabelConfig: SystemImageLabelConfig {
        let title = isUncompletedFiltered ? "Show active" : "Hide active"
        let systemName = isUncompletedFiltered ? "eye.slash" : "eye.fill"
        return SystemImageLabelConfig(title: title, systemName: systemName)
    }
    
    enum Filter {
        case none
        case uncompleted
        case completed
    }
    
    init(todos: [Todo]) {
        // It should come sorted from BE
        uncompletedTodos = todos.filter({ !$0.isCompleted })
        completedTodos = todos.filter({ $0.isCompleted })
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
    
    func addNewTaskButtonTapped() {
        if isAddingNewTodo {
            createInlineTodo()
        }
        isAddingNewTodo = true
    }
    
    func onNewTodoSubmit() {
        isAddingNewTodo = false
        createInlineTodo()
    }
    
    func onDelete(indexSet: IndexSet) {
        for index in indexSet {
            let todo = todos[index]
            let todos = todo.isCompleted ? completedTodos : uncompletedTodos
            guard let firstIndex = firstIndex(withId: todo.id, from: todos) else { return }
            if todo.isCompleted {
                completedTodos.remove(at: firstIndex)
            } else {
                uncompletedTodos.remove(at: firstIndex)
            }
        }
    }
    
    func onMove(indexSet: IndexSet, destination: Int) {
        for index in indexSet {
            let todo = todos[index]
            todo.isCompleted = (destination >= uncompletedTodos.count)
            var mutableTodos = todos
            mutableTodos.move(fromOffsets: [index], toOffset: destination)
            uncompletedTodos = mutableTodos.filter({ !$0.isCompleted })
            completedTodos = mutableTodos.filter({ $0.isCompleted })
        }
    }
    
    func hideCompltedButtonTapped() {
        applyOrToggle(filter: .completed)
    }
    
    func hideActiveButtonTapped() {
        applyOrToggle(filter: .uncompleted)
    }
    
    //MARK: - Variables
    private var currentFilter: Filter = .completed
    private var uncompletedTodos: [Todo]
    private var completedTodos: [Todo]
    private var isCompletedFiltered: Bool {
        currentFilter == .completed
    }
    
    private var isUncompletedFiltered: Bool {
        currentFilter == .uncompleted
    }
    
    //MARK: - Implementation
    
    private func createInlineTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = Todo(serverId: nil, id: UUID(), title: newTodoTitle, isCompleted: false)
        uncompletedTodos.append(newTodo)
        // Clear the textfield for the new inline todo
        newTodoTitle = ""
    }
    
    private func firstIndex(withId id: UUID, from todos: [Todo]) -> Int? {
        todos.firstIndex(where: { $0.id == id })
    }
    
    private func applyOrToggle(filter: Filter) {
        if currentFilter == filter {
            currentFilter = .none
        } else {
            currentFilter = filter
        }
    }
    
}

struct SystemImageLabelConfig {
    let title: String
    let systemName: String
}
