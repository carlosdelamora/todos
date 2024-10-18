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
                    .fontWeight(.heavy)
            }
            .contentShape(Rectangle())
            .buttonStyle(PlainButtonStyle())
        }
        .rowFrame()
    }
}

struct TextFieldRow: View {
    
    let title: String
    let isCompleted: Bool
    let buttonAction: () -> Void
    
    @Binding var textBinding: String
    var body: some View {
        HStack(spacing: 16) {
            Button(action: buttonAction) {
                Image(systemName: "checkmark")
                    .foregroundStyle(isCompleted ? .green : .disabled)
                    .fontWeight(.heavy)
            }
            .contentShape(Rectangle())
            .buttonStyle(PlainButtonStyle())
            DefaultTextField(
                text: $textBinding,
                promptString: nil
            )
        }
    }
}
