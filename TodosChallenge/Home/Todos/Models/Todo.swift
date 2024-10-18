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
    
    convenience init(dto: TodoDTO) {
        self.init(serverId: dto.serverId, id: UUID(), title: dto.title, isCompleted: dto.completed)
    }
}

extension Todo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .todo)
        ProxyRepresentation(exporting: \.title)
    }
}

