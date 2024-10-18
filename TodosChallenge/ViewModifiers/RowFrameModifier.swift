//
//  RowFrameModifier.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/13/24.
//

import SwiftUI

fileprivate struct RowFrameModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 40)
            .alignmentGuide(.listRowSeparatorLeading) { alingments in
                alingments[.leading] - 16
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

extension View {
    func rowFrame() -> some View {
        modifier(RowFrameModifier())
    }
}
