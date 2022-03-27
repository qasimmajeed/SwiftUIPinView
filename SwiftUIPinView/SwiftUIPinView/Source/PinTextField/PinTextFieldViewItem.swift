//
//  PinTextFieldViewItem.swift
//  SwiftUIPinView
//

import SwiftUI

struct PinTextField: UIViewRepresentable {
    // MARK: - Public Properties
    @ObservedObject public var viewItem: PinTextFieldViewItem
    public var onTextChange: ((String) -> Void)
    public var onBackPressed: ((PinTextFieldViewItem) -> Void)
    
    // MARK: - UIViewRepresentable Methods
    func makeUIView(context: UIViewRepresentableContext<PinTextField>) -> BackPressTextfield {
        let textField = BackPressTextfield(frame: .zero)
        textField.isSecureTextEntry = true
        textField.keyboardType = .numberPad
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.placeholder = viewItem.placeHolderText
        textField.text = viewItem.text
        textField.borderStyle = .none
        textField.backDelegate = context.coordinator
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }
    
    func updateUIView(_ uiView: BackPressTextfield, context: Context) {
        self.updateResponder(textField: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Private Methods
    private func updateResponder(textField: BackPressTextfield) {
        textField.tag = viewItem.tag
        textField.text = viewItem.text
        if viewItem.isInFocus {
            textField.becomeFirstResponder()
        }
    }
    
    final class Coordinator: NSObject, UITextFieldDelegate, BackPressTextfieldDelegate {
        // MARK: - Properties
        private let parent: PinTextField
        
        init(_ textField: PinTextField) {
            self.parent = textField
        }
        
        // MARK: - UITextFieldDelegate Methods
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            parent.onTextChange(string)
            return false
        }
        
        // MARK: - BackPressTextfieldDelegate Methods
        func backPressed(textfield: BackPressTextfield) {
            parent.onBackPressed(parent.viewItem)
        }
    }
}
