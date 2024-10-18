
import SwiftUI

struct SingleTodoListView: View {
    
    init(todos: [Todo]) {
        _viewModel = State(wrappedValue: SingleTodoViewModel(todos: todos))
    }
    
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
                            @Bindable var todo = todo
                            TextFieldRow(
                                title: todo.title,
                                isCompleted: todo.isCompleted,
                                buttonAction: {
                                    withAnimation {
                                        viewModel.didTappCheckButton(todo: todo)
                                    }
                                },
                                textBinding: $todo.title
                            )
                            .focused($inlineFocusState, equals: todo.id )
                            .rowFrame()
                        }
                        .listRowBackground(Color.backgroundPrimary)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                    .onDelete(perform: viewModel.onDelete)
                    .onMove(perform: viewModel.onMove)
                    
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
                    }
                }
            }
            .foregroundStyle(Color.disabled)
            .frame(height: 56)
            .padding(.horizontal)
            Divider()
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        viewModel.hideCompltedButtonTapped()
                    } label: {
                        Label(viewModel.hideCompletedLabelConfig.title,
                              systemImage: viewModel.hideCompletedLabelConfig.systemName
                        )
                    }
                    Button {
                        viewModel.hideActiveButtonTapped()
                    } label: {
                        Label(viewModel.hideUncompletedLabelConfig.title,
                              systemImage: viewModel.hideUncompletedLabelConfig.systemName
                        )
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
    }
}


#Preview {
    NavigationStack {
        SingleTodoListView(todos: TodosStub.todos)
    }
}

