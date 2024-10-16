//
//  TodoListRow.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/13/24.
//

import SwiftUI

struct TodoListRow: View {
    
    //MARK: - API
    
    init(_ title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
    
    var body: some View {
        HStack(spacing: 16) {
            RowContentView(title) {
                if isCompleted {
                    Image(systemName: "checkmark")
                        .fontWeight(.bold)
                        .foregroundStyle(Color.disabled)
                        .frame(minWidth: 24, minHeight: 24)
                }
            }
        }
        .rowFrame()
        .alignmentGuide(.listRowSeparatorLeading) { alingments in
            alingments[.leading] - 16
        }
    }
    
    private let isCompleted: Bool
    private let title: String
}

#Preview {
    List {
        TodoListRow("Buy milk", isCompleted: true)
        TodoListRow("Wash the dishes", isCompleted: false)
    }
    .listStyle(PlainListStyle())
}

extension Color {
    static var disabled: Color {
        .gray.opacity(0.5)
    }
    
    static var backgroundPrimary: Color {
        Color.white
    }
}


