//
//  TodosList.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//
import SwiftUI

struct TodosList: View {
    
    @Environment(\.editMode) private var editMode
//    @Environment(TodoManager.self) private var todoManager: TodoManager
    var todoManager: TodoManager
    
    var body: some View {
        List {
            ForEach(todoManager.todos) { todo in
                Text(todo.title)
            }
            .onDelete {
                todoManager.delete($0)
            }
        }
        .toolbar {
//            Button("Add Todo") {
//                editMode?.wrappedValue = .active
//            }
            EditButton()
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    NavigationStack {
        TodosList(todoManager: TodoManager(todos: TodosStub.todos))
    }
}
