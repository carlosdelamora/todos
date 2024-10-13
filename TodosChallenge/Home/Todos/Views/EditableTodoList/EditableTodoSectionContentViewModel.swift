//
//  EditableTodoSectionContentViewModel.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/12/24.
//

import Foundation

@Observable
class EditableTodoSectionContentViewModel {
    
    var todos: [Todo]
    var newTodoTitle: String = ""
    var isEditingTodoId: UUID?
    var isAddingInlineTodo = false
    
    init(todos: [Todo]) {
        self.todos = todos
    }
    
    func onDelete(indexSet: IndexSet) {
        todos.remove(atOffsets: indexSet)
    }
    
    func onMove(indexSet: IndexSet, detstination: Int) {
        todos.move(fromOffsets: indexSet, toOffset: detstination)
    }
    
    func onNewTodoSubmit() {
        isAddingInlineTodo = false
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = Todo(serverId: nil, id: UUID(), title: newTodoTitle, isCompleted: false)
        todos.append(newTodo)
        // Clear the textfield for the new inline todo
        newTodoTitle = ""
        //Hide the textField for the new inline todo
        isAddingInlineTodo = false
    }
}
