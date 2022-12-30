//
//  WrappedTextField.swift
//  Costs
//
//  Created by Dávid Godzsák on 25/12/2022.
//

import SwiftUI

struct TextFieldWithKeyboard: UIViewRepresentable {
    var keyboard: NumberKeyboard
    var placeholder: String = ""
    var openByDefault: Bool = false
    @Binding var text: String
    
    func makeUIView(context: Context) -> TextFieldForCustomKeyboard {
        let field = TextFieldForCustomKeyboard(keyboard: keyboard, placeholder: placeholder)
        field.delegate = context.coordinator
        
        if openByDefault {
            field.becomeFirstResponder()
        }
        
        return field
    }
    
    func updateUIView(_ view: TextFieldForCustomKeyboard, context: Context) {
        view.text = text
    }
    
    func makeCoordinator() -> TextFieldWithKeyboard.Coordinator {
        Coordinator(self.$text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var value: Binding<String>
        
        init(_ value: Binding<String>) {
            self.value = value
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            print("asdasd")
            self.value.wrappedValue = textField.text ?? ""
            return true
        }
    }
}
