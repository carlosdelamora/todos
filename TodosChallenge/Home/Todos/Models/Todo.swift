//
//  Todo.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//
import Foundation

struct Todo: Identifiable {
    let serverId: Int?
    let id: UUID
    var title: String
    var isCompleted: Bool
}
