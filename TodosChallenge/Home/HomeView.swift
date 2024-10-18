//
//  HomeView.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(homeViewModel.listInfo) { listInfo in
                    NavigationLink(value: listInfo.id) {
                        RowContentView(listInfo.name)
                    }
                }
            }
            .navigationDestination(for: ListInfo.ID.self) { id in
                if let listInfo = homeViewModel.listInfo.first(where: { $0.id == id }) {
                    TodosView()
                        .navigationTitle(listInfo.name)
                }
            }
        }.task {
            await homeViewModel.initalTask()
        }
    }
}

#Preview {
    HomeView()
}
