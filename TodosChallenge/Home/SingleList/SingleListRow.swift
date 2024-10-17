//
//  SingleListRow.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/16/24.
//

import SwiftUI


struct SingleListRow : View {
    
    let title: String
    let isCompleted: Bool
    let action: () -> Void
    var body: some View {
        RowContentView(title) {
            Button(action: action) {
                Image(systemName: "checkmark")
                    .foregroundStyle(isCompleted ? .green : .disabled)
            }
            .contentShape(Rectangle())
            .buttonStyle(PlainButtonStyle())
        }
        .rowFrame()
    }
}
