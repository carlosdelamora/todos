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
            .frame(maxWidth: .infinity, minHeight: 54)
            .alignmentGuide(.listRowSeparatorLeading) { alingments in
                alingments[.leading] - 16
            }
    }
}

extension View {
    func rowFrame() -> some View {
        modifier(RowFrameModifier())
    }
}
