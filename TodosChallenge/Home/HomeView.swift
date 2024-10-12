//
//  HomeView.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/11/24.
//

import SwiftUI

struct HomeView: View {
    @State private var navigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Button("My Todos") {
                navigationPath.append("mytodo")
            }
            .navigationDestination(for: String.self) { _ in
                TodosView()
            }
        }
        
    }
}

#Preview {
    HomeView()
}
