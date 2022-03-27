//
//  PinTextField.swift
//  SwiftUIPinView
//

import SwiftUI
import Combine

final class PinTextFieldViewItem: ObservableObject, Identifiable {
    // MARK: - Public Properties
    @Published public var isInFocus: Bool
    @Published public var text: String = ""
    public let placeHolderText: String
    public let tag: Int
    
    // MARK: - init
    init(text: String, placeHolderText: String, isInFocus: Bool = false,
         tag: Int) {
        self.text = text
        self.placeHolderText = placeHolderText
        self.isInFocus = isInFocus
        self.tag = tag
    }
}
