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
    @Bindable var viewModel: TodoListViewModel
    @FocusState private var focusState: Field?
    
    enum Field: Hashable {
        case edit
        case new
    }
    
    var body: some View {
        
            VStack {
                List {
                    Section(header: Text("TODS LIST")) {
                        EditableTodoSectionContent(
                            viewModel: viewModel.uncompletedSectionContentViewModel
                        )
                        .dropDestination(for: Todo.self) { payload, destinationIndex  in
                            viewModel.move(
                                    todos: payload,
                                    from: &viewModel.completedSectionContentViewModel.todos,
                                    to: &viewModel.uncompletedSectionContentViewModel.todos,
                                    destinationIndex: destinationIndex
                                )
                        }
                    }
                }
                Button("Add Todo") {
                    withAnimation {
                        viewModel.addTodoButtonTapped()
                    }
                }
                .foregroundStyle(Color.accentColor)
                List {
                    Section(header: Text("COMPLETED")) {
                        EditableTodoSectionContent(
                            viewModel: viewModel.completedSectionContentViewModel
                        )
                        .dropDestination(for: Todo.self) { payload, destinationIndex  in
                            viewModel.move(
                                todos: payload,
                                from: &viewModel.uncompletedSectionContentViewModel.todos,
                                to: &viewModel.completedSectionContentViewModel.todos,
                                destinationIndex: destinationIndex
                            )
                        }
                    }
                }
            }
           
        
        .toolbar {
//            Button("Add Todo") {
//                editMode?.wrappedValue = .active
//            }
            EditButton()
        }
        .listStyle(PlainListStyle())
        .environment(\.editMode, $viewModel.editMode)
    }
}

#Preview {
    NavigationStack {
        TodosList(viewModel: TodoListViewModel(todos: TodosStub.todos))
    }
}
