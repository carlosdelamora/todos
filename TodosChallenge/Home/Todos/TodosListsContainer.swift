//
//  TodosListsContainer.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//
import SwiftUI

struct TodosListsContainer: View {
    
    @Bindable var viewModel: TodosListsContainerViewModel
    @FocusState private var focusState: Field?
    
    enum Field: Hashable {
        case edit
        case new
    }
    
    var body: some View {
        
        VStack {
            ScrollViewReader { scrollViewProxy in
                List {
                    Section(header: SectionHeader("TODO LIST")) {
                        EditableTodoSectionContent(
                            viewModel: viewModel.uncompletedSectionContentViewModel, scrollViewProxy: scrollViewProxy
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
            }
            
            ScrollViewReader { scrollViewProxy in
                List {
                    Section(header: SectionHeader("COMPLETED")) {
                        EditableTodoSectionContent(
                            viewModel: viewModel.completedSectionContentViewModel, scrollViewProxy: scrollViewProxy
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
                    .scrollTargetLayout()
                }
            }
            
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
        .toolbar {
            EditButton()
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        TodosListsContainer(viewModel: TodosListsContainerViewModel(todos: TodosStub.todos))
    }
}
