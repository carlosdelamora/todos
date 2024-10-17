//
//  Todo.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//
import Foundation
import CoreTransferable

class Todo: Identifiable, Codable {
    let serverId: Int?
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    init(serverId: Int?, id: UUID, title: String, isCompleted: Bool) {
        self.serverId = serverId
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

extension Todo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .todo)
        ProxyRepresentation(exporting: \.title)
    }
}

