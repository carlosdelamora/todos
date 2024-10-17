
import SwiftUI

struct SingleTodoListView: View {
    
    @State var viewModel: SingleTodoViewModel
    @FocusState private var newTodoFocusState: Field?
    @FocusState private var inlineFocusState: UUID?
    @State private var scrollProxy: ScrollViewProxy?

    private enum Field: Hashable {
        case new
    }
    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { scrollProxy in
                List(selection: $viewModel.isEditingTodoId) {
                    ForEach(viewModel.todos) { todo in
                        Group {
                            if viewModel.isEditingTodoId == todo.id {
                                let textBinding = Binding {
                                    todo.title
                                } set: {
                                    todo.title = $0
                                }
                                DefaultTextField(
                                    text: textBinding,
                                    promptString: nil
                                )
                                .focused($inlineFocusState, equals: todo.id )
                                .rowFrame()
                                .onAppear {
                                    inlineFocusState = todo.id
                                }
                            } else {
                                SingleListRow(title: todo.title, isCompleted: todo.isCompleted) {
                                    withAnimation {
                                        viewModel.didTappCheckButton(todo: todo)
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color.backgroundPrimary)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                    .onDelete(perform: viewModel.onDelete)
                    .onMove(perform: viewModel.onMove)
                    .onChange(of: inlineFocusState) { oldValue, newValue in
                        if newValue == nil {
                            viewModel.isEditingTodoId = nil
                        }
                    }
                    
                    Group {
                        if viewModel.isAddingNewTodo {
                            DefaultTextField(text: $viewModel.newTodoTitle , promptString: "What do you want to do?") {
                                viewModel.onNewTodoSubmit()
                            }
                            .rowFrame()
                            .focused($newTodoFocusState, equals: .new)
                            .onAppear {
                                newTodoFocusState = .new
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .id(viewModel.bottomId)
                    .onChange(of: newTodoFocusState) { oldValue, newValue in
                        if newValue != .new {
                            viewModel.isAddingNewTodo = false
                        }
                    }
                    .onChange(of: viewModel.newTodoTitle) { _, _ in
                        withAnimation {
                            scrollProxy.scrollTo(viewModel.bottomId)
                        }
                    }
                    .onChange(of: viewModel.isAddingNewTodo) { _, isAddingInlineTodo in
                        if isAddingInlineTodo {
                            withAnimation {
                                scrollProxy.scrollTo(viewModel.bottomId)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollDismissesKeyboard(.interactively)
                .onAppear {
                    self.scrollProxy = scrollProxy
                }
            }
            
            Divider()
            Button {
                withAnimation {
                    viewModel.addNewTaskButtonTapped()
                    scrollProxy?.scrollTo(viewModel.bottomId)
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


#Preview {
    SingleTodoListView(viewModel: SingleTodoViewModel(todos: TodosStub.todos))
}

