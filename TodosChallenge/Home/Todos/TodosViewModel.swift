//
//  TodoListViewModel.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//

import Combine
import SwiftUI
import Factory

@MainActor
@Observable
class TodosViewModel {
    
    //MARK: - API
    
    private(set) var loadingState: LoadingState<[Todo]> = .loading
    
    func initalTask() async {
        loadingState = .loading
        do {
            let todoDTOs = try await todoProvider.todos()
            let todos = todoDTOs.map( { Todo(dto: $0)})
            loadingState = .loaded(todos)
        } catch {
            loadingState = .error(error)
        }
    }
    
    //MARK: - Constants
    
    //MARK: - Variables
    
    @ObservationIgnored
    @Injected(\.todoProvider) var todoProvider
}

enum LoadingState<T> {
    case loading
    case loaded(T)
    case error(Error)
}
  
extension Container {
    
    var todoProvider: Factory<TodoProviding> {
        self { TodoProvider() }
    }
}

protocol TodoProviding {
    func todos() async throws -> [TodoDTO]
}

class TodoProvider: TodoProviding {
    
    func todos() async throws -> [TodoDTO] {
        guard var url = URL(string: "https://jsonplaceholder.typicode.com") else {
            throw NetworkError
            .invalidURL}
        url.append(path: "todos")
        let request = URLRequest(url: url)
        let todosDTOs = try await urlRequest(responseType: [TodoDTO].self, request: request)
        return Array(todosDTOs.filter({ $0.userId == 3 }).prefix(5))
    }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case httpError(Int)
    }
    
    private func urlRequest<T: Decodable>(responseType: T.Type, request: URLRequest) async throws -> T {
        let (data, httpResponse) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        
        let dto = try JSONDecoder().decode(T.self, from: data)
        return dto
    }
}
