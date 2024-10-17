//
//  EditableTodoSectionContent.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/12/24.
//

import SwiftUI
import Combine

struct EditableTodoSectionContent: DynamicViewContent {
    
    @Bindable var viewModel: EditableTodoSectionContentViewModel
    var scrollViewProxy: ScrollViewProxy
    @FocusState private var focusState: Field?
    @FocusState private var inlineFocusState: UUID?
    private enum Field: Hashable {
        case new
    }
    var data: [Todo] { viewModel.todos }
    
    var body: some View {
        ForEach($viewModel.todos) { $todo in
            Group {
                if viewModel.isEditingTodoId == todo.id {
                    DefaultTextField(
                        text: $todo.title ,
                        promptString: nil
                    ) {
                        
                    }
                    .focused($inlineFocusState, equals: todo.id )
                    .rowFrame()
                    .onChange(of: inlineFocusState) { oldValue, newValue in
                        if newValue != todo.id {
                            viewModel.isEditingTodoId = nil // do this in the viewModel
                        }
                    }
                } else {
                    TodoListRow(todo.title, isCompleted: todo.isCompleted)
                        .contentShape(Rectangle())
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
        
        Group {
            if viewModel.isAddingInlineTodo {
                DefaultTextField(text: $viewModel.newTodoTitle , promptString: "What do you want to do?") {
                    viewModel.onNewTodoSubmit()
                }
                .focused($focusState, equals: .new)
                .onAppear {
                    focusState = .new
                }
                .onChange(of: focusState) { oldValue, newValue in
                    if newValue != .new {
                        viewModel.isAddingInlineTodo = false // do this in the viewModel
                    }
                }
            }
        }
        .id(viewModel.bottomId)
        .onReceive(
            NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                if viewModel.isAddingInlineTodo {
                    scrollToBottom()
                }
        }
        .onChange(of: viewModel.isAddingInlineTodo) { oldValue, newValue in
            if newValue {
                scrollToBottom()
            }
        }
        .onChange(of: viewModel.todos.last?.id) { _,_ in
            scrollToBottom()
        }
        .moveDisabled(true)
        .rowFrame()
    }
    
    private func scrollToBottom() {
        withAnimation {
            scrollViewProxy.scrollTo(viewModel.bottomId, anchor: .bottom)
        }
    }
}

#Preview {
    NavigationStack {
        ScrollViewReader { scrollViewProxy in
            List {
                EditableTodoSectionContent(
                    viewModel: EditableTodoSectionContentViewModel(todos: TodosStub.todos),
                    scrollViewProxy: scrollViewProxy
                )
                .listRowInsets(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            .listStyle(.plain)
            .toolbar {
                EditButton()
            }
        }
    }
}
