//
//  RowContentView.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/13/24.
//

import SwiftUI

struct RowContentView<LeftContent: View>: View {
    
    init(_ title: String, @ViewBuilder leftContent: (() -> LeftContent) = { EmptyView() }) {
        self.title = title
        self.leftContent = leftContent()
    }
    
    private let title: String
    private let leftContent: LeftContent
    
    var body: some View {
        HStack(spacing: 16) {
            leftContent
            MediumText(title)
            Spacer()
        }
    }
}

#Preview {
    VStack {
        RowContentView("title")
        RowContentView("title") {
            Image(systemName: "checkmark")
                .fontWeight(.bold)
                .foregroundStyle(Color.disabled)
                .frame(minWidth: 24, minHeight: 24)
        }
    }
    .padding()
    
}
