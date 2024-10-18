//
//  TodoProviding.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/18/24.
//

import Foundation
import Factory
import Networking

protocol TodoProviding {
    func todos() async throws -> [TodoDTO]
}

class TodoProvider: TodoProviding {
    
    //MARK: - API
    
    func todos() async throws -> [TodoDTO] {
        guard var url = URL(string: "https://jsonplaceholder.typicode.com") else {
            throw TodoError
            .invalidURL}
        url.append(path: "todos")
        let request = URLRequest(url: url)
        let todosDTOs = try await networkClient.urlRequest(
            responseType: [TodoDTO].self,
            request: request
        )
        return Array(todosDTOs.filter({ $0.userId == 3 }).prefix(5))
    }
    
    enum TodoError: Error {
        case invalidURL
    }
    
    //MARK: - Constants
    
    //MARK: - Variables
    
    @Injected(\.networkClient) var networkClient: NetworkClient
    
}

extension Container {
    
    var networkClient: Factory<NetworkClient> {
        self { DefaultNetworkClient() }
    }
}
