//
//  SectionHeader.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/13/24.
//

import SwiftUI

struct MediumText: View {
    init(_ text: String) {
        self.text = text
    }
    private let text: String
    var body: some View {
        Text(text)
            .font(.accordMedium)
    }
}

#Preview {
    MediumText("Hello world!")
}

struct SectionHeader: View {
    init(_ text: String) {
        self.text = text
    }
    private let text: String
    var body: some View {
        Text(text.uppercased())
            .font(.custom("AccordAlternate-Medium", size: 20))
            .frame(height: 40)
    }
}
