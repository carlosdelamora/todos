//
//  Todo.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//
import Foundation
import CoreTransferable

struct Todo: Identifiable, Codable {
    let serverId: Int?
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    func toggleCompleted() -> Todo {
        var mutableSelf = self
        mutableSelf.isCompleted.toggle()
        return mutableSelf
    }
}

extension Todo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .todo)
        //ProxyRepresentation(exporting: \.name))
    }
}

