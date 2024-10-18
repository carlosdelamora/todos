//
//  SingleTodoViewModelTest.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/17/24.
//
import Foundation
import Testing
@testable import TodosChallenge

@MainActor
struct TodosChallengeTests {
    
    @Test func filteredTodos() {
        let uncompleted = makeTodos(count: 5, isCompleted: false)
        let completed = makeTodos(count: 8, isCompleted: true)
        let allTodos = uncompleted + completed
        let viewModel = SingleTodoViewModel(todos: allTodos)
        
        // By default we show only the uncompleted todos
        #expect(viewModel.todos.count == uncompleted.count)
        #expect(viewModel.hideCompletedLabelConfig.title == "Show completed")
        #expect(viewModel.hideCompletedLabelConfig.systemName == "eye.slash")
        #expect(viewModel.hideUncompletedLabelConfig.title == "Hide active")
        #expect(viewModel.hideUncompletedLabelConfig.systemName ==  "eye.fill")
        // When filtering uncompleted we expect only completed to show
        viewModel.hideActiveButtonTapped()
        #expect(viewModel.todos.count == completed.count)
        #expect(viewModel.hideCompletedLabelConfig.title == "Hide completed")
        #expect(viewModel.hideCompletedLabelConfig.systemName == "eye.fill")
        #expect(viewModel.hideUncompletedLabelConfig.title == "Show active")
        #expect(viewModel.hideUncompletedLabelConfig.systemName ==  "eye.slash")
        
        // When filtering completed we expect only uncompleted
        viewModel.hideCompltedButtonTapped()
        #expect(viewModel.todos.count == uncompleted.count)
    }
    
    @Test func didTapCheckButtonCompleted() {
        let (_, completed, viewModel) = makeDataUnderTest(
            uncompletedCount: 7,
            completedCount: 4
        )
        let todo = completed[2]
        #expect(todo.isCompleted)
        
        // When changing to filter uncompleted
        viewModel.hideActiveButtonTapped()
        // and When tapping on the check button
        viewModel.didTappCheckButton(todo: todo)
        
        // It's expected for todo to be uncompleted
        #expect(!todo.isCompleted)
        // It's expected for todo to not be present
        #expect(!viewModel.todos.map({ $0.id}).contains(todo.id))
        
        // When changing to filter uncompleted
        viewModel.hideCompltedButtonTapped()
        
        // It is expected for todo to be present on the last position
        #expect(viewModel.todos.last?.id == todo.id)
    }

    
    @Test func didTapCheckButtonOnUncompleted() {
        let (uncompleted, _, viewModel) = makeDataUnderTest(
            uncompletedCount: 7,
            completedCount: 4
        )
        let todo = uncompleted[2]
        #expect(!todo.isCompleted)
        // When tapping on the check button, default filter .completed
        viewModel.didTappCheckButton(todo: todo)
        #expect(todo.isCompleted)
        // It's expected for todo to not be present
        #expect(!viewModel.todos.map({ $0.id}).contains(todo.id))
        
        // When changing to filter uncompleted
        viewModel.hideActiveButtonTapped()
        
        // It is expected for todo to be present on the first position
        #expect(viewModel.todos.first?.id == todo.id)
    }
    
    @Test func addNewTaskButtonTapped() throws {
        let (uncompleted, _, viewModel) = makeDataUnderTest(
            uncompletedCount: 5,
            completedCount: 2
        )
        #expect(!viewModel.isAddingNewTodo)
        
        // When add new task button tapped
        viewModel.addNewTaskButtonTapped()
        // We expect the isAddingNewTodo to be true
        #expect(viewModel.isAddingNewTodo)
        
        // When new newTodoTitle is not empty
        viewModel.newTodoTitle = "I'm a new todo"
        // and add new todo button tapped again
        viewModel.addNewTaskButtonTapped()
        
        // We expect a new todo to be created (and currentFilter = .completed)
        #expect(viewModel.todos.count == uncompleted.count + 1)
        
        let newTodo = try #require(viewModel.todos.last)
        // We expect the new todo title to match
        #expect(newTodo.title == "I'm a new todo")
        // We expect a reset of the viewModel.newTodoTitile
        #expect(viewModel.newTodoTitle.isEmpty)
    }
    
    @Test func onNewTodoSubmit() {
        let (uncompleted, _, viewModel) = makeDataUnderTest(
            uncompletedCount: 5,
            completedCount: 2
        )
        
        //When add a new task button is tapped
        viewModel.addNewTaskButtonTapped()
        
        // We expect the isAddingNewTodo to be true
        #expect(viewModel.isAddingNewTodo)

        // When onNewTodoSubmit is called ( the user taps return on the keyboard)
        viewModel.onNewTodoSubmit()
        
        // We expect the isAddingNewTodo to be false
        #expect(!viewModel.isAddingNewTodo)
        
        // Is expected that no new task is created
        #expect(viewModel.todos.count == uncompleted.count)
    }
    
    @Test func onDelete()  {
        let (uncompleted, completed, viewModel) = makeDataUnderTest(
            uncompletedCount: 4,
            completedCount: 6
        )
        
        let indexToDelete = uncompleted.count - 2
        let indexSetToDelete = IndexSet([indexToDelete])
        let todoToDeleteId = uncompleted[indexToDelete].id
        viewModel.onDelete(indexSet: indexSetToDelete)
        #expect(uncompleted.count - 1 == viewModel.todos.count)
        #expect(!viewModel.todos.contains(where: { $0.id == todoToDeleteId }))
        
        // when we hide the uncompleted todos
        viewModel.hideActiveButtonTapped()
        
        let indexCompleteToDelete = completed.count - 4
        let indexSet = IndexSet([indexCompleteToDelete])
        let completedTodoToDeleteId = uncompleted[indexCompleteToDelete].id
        viewModel.onDelete(indexSet: indexSet)
        #expect(completed.count - 1 == viewModel.todos.count)
        #expect(!viewModel.todos.contains(where: { $0.id == completedTodoToDeleteId }))
    }
    
    @Test func onMove() {
        let (uncompleted, completed, viewModel) = makeDataUnderTest(
            uncompletedCount: 9,
            completedCount: 6
        )
        
        // When the filter is none
        viewModel.hideCompltedButtonTapped()
        #expect(viewModel.todos.count == uncompleted.count + completed.count)
        
        // When we move from a uncompleted to completed
        let indexToMove = uncompleted.count - 4
        let todoToMove = uncompleted[indexToMove]
        let destination = uncompleted.count + 3
        viewModel.onMove(indexSet: IndexSet([indexToMove]), destination: destination)
        
        // We expect the todo to be completed
        #expect(todoToMove.isCompleted)
        let firstIndex = viewModel.todos.firstIndex(where: { todoToMove.id == $0.id})
        // We expect it to be at the destination index
        #expect(viewModel.todos[destination - 1].id == todoToMove.id)
        
    }
    
    func makeDataUnderTest(
        uncompletedCount: Int,
        completedCount: Int
    ) -> (uncompleted: [Todo], completed: [Todo], viewModel: SingleTodoViewModel) {
        let uncompletedTodos = makeTodos(count: uncompletedCount, isCompleted: false)
        let completedTodos = makeTodos(count: completedCount, isCompleted: true)
        return (
            uncompletedTodos,
            completedTodos,
            SingleTodoViewModel(todos: uncompletedTodos + completedTodos)
        )
    }
    
    func makeTodos(count: Int, isCompleted: Bool) -> [Todo] {
        (0..<count).map { _ in
            let uuid = UUID()
            return Todo(
                serverId: nil,
                id: UUID(),
                title: uuid.uuidString,
                isCompleted: isCompleted
            )
        }
    }
}
