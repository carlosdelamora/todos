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
    var onSubmit: (()-> Void)? = nil
    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: prompt,
            axis: .vertical
        )
        .onChange(of: text) { oldValue, newValue in
            if newValue.contains(where: \.isNewline) {
                text = oldValue
                hideKeyboard()
                onSubmit?()
            }
        }
        .font(.accordMedium)
    }
    
    @ViewBuilder
    private var prompt: Text? {
        if let promptString {
            Text(promptString)
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
