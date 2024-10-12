//
//  TodoList.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//

import SwiftUI

struct TodosView: View {
    @State private var viewModel = TodosViewModel()
    var body: some View {
        switch viewModel.loadingState {
        case .loading:
            Text("Loading...")
        case .loaded(let todoManager):
            if todoManager.isEmpty {
                Text("Empty")
            }
            
            if !todoManager.isEmpty {
                TodosList(todoManager: todoManager)
            }
            
        case .error:
            Text("Error")
        }
        List {
            
        }
    }
}

#Preview {
    TodosView()
}
