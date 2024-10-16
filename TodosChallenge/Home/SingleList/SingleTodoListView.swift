
import SwiftUI

struct SingleTodoListView: View {
    
    @State var viewModel: SingleTodoViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.todos) { todo in
                    Group {
                        if viewModel.isEditingTodoId == todo.id {
                            DefaultTextField(
                                text: viewModel.bindTo(todo: todo).title,
                                promptString: nil
                            ) {
                                
                            }
//                            .focused($inlineFocusState, equals: todo.id )
                            .rowFrame()
//                            .onChange(of: inlineFocusState) { oldValue, newValue in
//                                if newValue != todo.id {
//                                    viewModel.isEditingTodoId = nil // do this in the viewModel
//                                }
//                            }
                        } else {
                            SingleListRow(title: todo.title, isCompleted: todo.isCompleted) {
                                withAnimation {
                                    viewModel.didTappCheckButton(todo: todo)
                                }
                            }
                            .onTapGesture {
                                viewModel.isEditingTodoId = todo.id
                            }
                        }
                    }
                }
//                .onDelete(perform: viewModel.onDelete)
//                .onMove(perform: viewModel.onMove)
                
                Group {
                    if viewModel.isAddingInlineTodo {
                        DefaultTextField(text: $viewModel.newTodoTitle , promptString: "What do you want to do?") {
                            viewModel.onNewTodoSubmit()
                        }
                        .rowFrame()
//                        .focused($focusState, equals: .new)
//                        .onAppear {
//                            focusState = .new
//                        }
//                        .onChange(of: focusState) { oldValue, newValue in
//                            if newValue != .new {
//                                viewModel.isAddingInlineTodo = false // do this in the viewModel
//                            }
//                        }
                    }
                }
                .id(viewModel.bottomId)
            }
            .listStyle(.plain)
            
            Divider()
            Button {
                withAnimation {
                    viewModel.addTodoButtonTapped()
                }
            } label: {
                HStack {
                    RowContentView("Add task") {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                            .frame(minWidth: 24, minHeight: 24)
                            
                    }
                }
               
            }
            .foregroundStyle(Color.disabled)
            .rowFrame()
            .padding(.horizontal)
            Divider()
        }
    }
}

struct SingleListRow : View {
    
    let title: String
    let isCompleted: Bool
    let action: () -> Void
    var body: some View {
        RowContentView(title) {
            Button(action: action) {
                Image(systemName: "checkmark")
                    .foregroundStyle(isCompleted ? .green : .disabled)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .rowFrame()
    }
}

#Preview {
    SingleTodoListView(viewModel: SingleTodoViewModel(todos: TodosStub.todos))
}

