//
//  ListInfo.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/16/24.
//

import Foundation
import Factory

struct ListInfo: Identifiable {
    let id: UUID
    let name: String
}


class DefaultListInfoProvider {
    func listInfos() async -> [ListInfo] {
        [
            .init(id: UUID(), name: "Home"),
            .init(id: UUID(), name: "Work"),
            .init(id: UUID(), name: "Vacations"),
        ]
    }
}

@Observable
@MainActor
class HomeViewModel {
    var listInfo: [ListInfo] = []
    @ObservationIgnored
    @Injected(\.listInfoProvider) private var listInfoProvider
    
    func initalTask() async {
        listInfo = await listInfoProvider.listInfos()
    }
}


extension Container {
    
    var listInfoProvider: Factory<DefaultListInfoProvider> {
        self { DefaultListInfoProvider()}
    }
}
