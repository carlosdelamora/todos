//
//  DefaultTextField.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/12/24.
//

import SwiftUI

struct DefaultTextField: View {
    @Binding var text: String
    var promptString: String?
    var onSubmit: ()-> Void
    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: prompt
        )
        .onSubmit {
            onSubmit()
        }
    }
    
    @ViewBuilder
    private var prompt: Text? {
        if let promptString {
            Text(promptString)
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    
    DefaultTextField(text: $text, promptString: "The border was added to make it easy to spot") {
        print("Did submit \(text)")
    }
    .textFieldStyle(.roundedBorder)
    .padding()
}
