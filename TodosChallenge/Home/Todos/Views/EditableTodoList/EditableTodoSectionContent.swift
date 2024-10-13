//
//  EditableTodoSectionContent.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/12/24.
//

import SwiftUI

struct EditableTodoSectionContent: DynamicViewContent {
    

    
    @Bindable var viewModel: EditableTodoSectionContentViewModel
    @FocusState private var focusState: Field?
    @FocusState private var inlineFocusState: UUID?
    private enum Field: Hashable {
        case inlineEditing
        case new
    }
    var data: [Todo] { viewModel.todos }
    
    var body: some View {
            ForEach($viewModel.todos) { $todo in
                Group {
                    if viewModel.isEditingTodoId == todo.id {
                        DefaultTextField(
                            text: $todo.title ,
                            promptString: "What do you want to do?"
                        ) {
                            viewModel.onNewTodoSubmit()
                        }
                        .focused($inlineFocusState, equals: todo.id )
                    } else {
                        Text(todo.title)
                        // Fix the tap target
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .onTapGesture {
                                inlineFocusState = todo.id
                                viewModel.isEditingTodoId = todo.id
                            }
                            .draggable(todo)
                    }
                }
            }
            .onDelete(perform: viewModel.onDelete)
            .onMove(perform: viewModel.onMove)
            
            if viewModel.isAddingInlineTodo {
                DefaultTextField(text: $viewModel.newTodoTitle , promptString: "What do you want to do?") {
                    viewModel.onNewTodoSubmit()
                }
                .focused($focusState, equals: .new)
                .onAppear {
                    focusState = .new
                }
                .moveDisabled(true)
            }
        
    }
}

#Preview {
    NavigationStack {
        EditableTodoSectionContent(
            viewModel: EditableTodoSectionContentViewModel(todos: TodosStub.todos)
        )
    }
}
