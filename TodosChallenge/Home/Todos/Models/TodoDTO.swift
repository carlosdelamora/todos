//
//  TodoDTO.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//

struct TodoDTO: Codable {
    let userId: Int
    let serverId: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userId
        case serverId = "id"
        case title
        case completed
    }
}

