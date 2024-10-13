//
//  TodosStub.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//
import Foundation

struct TodosStub {
    static var todos: [Todo] {
        (0..<5).map(
            {
                Todo(
                    serverId: $0,
                    id: UUID(),
                    title: "Todo \($0 ?? -1)",
                    isCompleted: Bool.random()
                )
            }
        )
    }
}
