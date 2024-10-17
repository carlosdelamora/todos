
import SwiftUI

struct SingleTodoListView: View {
    
    @State var viewModel: SingleTodoViewModel
    @FocusState private var focusState: Field?
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
                                .onChange(of: inlineFocusState) { oldValue, newValue in
                                    if newValue != todo.id {
                                        viewModel.isEditingTodoId = nil // do this in the viewModel
                                    }
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
                    
                    Group {
                        if viewModel.isAddingInlineTodo {
                            DefaultTextField(text: $viewModel.newTodoTitle , promptString: "What do you want to do?") {
                                viewModel.onNewTodoSubmit()
                            }
                            .rowFrame()
                            .focused($focusState, equals: .new)
                            .onAppear {
                                focusState = .new
                            }
                            .onChange(of: focusState) { oldValue, newValue in
                                if newValue != .new {
                                    //viewModel.isAddingInlineTodo = false // do this in the viewModel
                                }
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .id(viewModel.bottomId)
                    .onChange(of: viewModel.newTodoTitle) { _, _ in
                        withAnimation {
                            scrollProxy.scrollTo(viewModel.bottomId)
                        }
                    }
                    .onChange(of: viewModel.isAddingInlineTodo) { _, _ in
                        withAnimation {
                            scrollProxy.scrollTo(viewModel.bottomId)
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
            .contentShape(Rectangle())
            .buttonStyle(PlainButtonStyle())
        }
        .rowFrame()
    }
}

#Preview {
    SingleTodoListView(viewModel: SingleTodoViewModel(todos: TodosStub.todos))
}

