//
//  PinViewViewModel.swift
//  SwiftUIPinView
//

import Foundation
import Combine

final class PinViewViewModel: ObservableObject {
    // MARK: - Private Properties
    private let numberOfPins: Int
    private(set) lazy var pinViewItems: [PinTextFieldViewItem] = [PinTextFieldViewItem]()
    private let isFocusOnStart: Bool
    
    @Published var generatedPin: String = ""
    @Published var isError: Bool = false
    @Published var dismissAllKeyboard: Bool = false
    
    // MARK: - init
    public init(numberOfPins: Int, isFocusOnStart: Bool = true) {
        self.numberOfPins = numberOfPins
        self.isFocusOnStart = isFocusOnStart
        createTextFields()
    }
    
    // MARK: - Public Methods
    public func textFieldTextChange(replacementText: String, viewItem: PinTextFieldViewItem) {
        if replacementText.count == 0 && viewItem.text.count == 0 {
            if let previousViewItem = previousViewItemFrom(tag: viewItem.tag) {
                previousViewItem.text = ""
                viewItem.isInFocus = false
                previousViewItem.isInFocus = true
            }
        } else {
            if let nextViewItem = nextViewItemFrom(tag: viewItem.tag) {
                viewItem.isInFocus = false
                nextViewItem.isInFocus = true
            }
        }
        viewItem.text = replacementText
        sendPin()
    }
    
    public func onTextFieldBackPressed(viewItem: PinTextFieldViewItem) {
        if let previousViewItem = previousViewItemFrom(tag: viewItem.tag) {
            previousViewItem.text = ""
            viewItem.isInFocus = false
            previousViewItem.isInFocus = true
        }
        sendPin()
    }
    
    public func focusTextField(isFocus: Bool) {
        self.dismissAllKeyboard = true
        self.pinViewItems = self.pinViewItems.map({ pin in
            pin.isInFocus = false
            return pin
        })
        if isFocus {
            self.pinViewItems[0].isInFocus = true
        }
    }
    
    public func getNumberOfPins() -> Int {
        return numberOfPins
    }
    
    // MARK: - Private Methods
    private func createTextFields() {
        for i in 0..<numberOfPins {
            let viewItem = PinTextFieldViewItem(text: "", placeHolderText: "*", isInFocus: (i == 0) ? (isFocusOnStart ? true: false): false, tag: i)
            pinViewItems.append(viewItem)
        }
    }
    
    private func nextViewItemFrom(tag: Int) -> PinTextFieldViewItem? {
        let nextTextItemTag = tag + 1
        if nextTextItemTag < self.pinViewItems.count {
            return self.pinViewItems.filter { $0.tag == nextTextItemTag }.first
        }
        return nil
    }
    
    private func previousViewItemFrom(tag: Int) -> PinTextFieldViewItem? {
        let previousTextItemTag = tag - 1
        if previousTextItemTag >= 0 {
            return self.pinViewItems.filter { $0.tag == previousTextItemTag }.first
        }
        return nil
    }
    
    private func generatePin() -> String? {
        return self.pinViewItems.reduce("") { $0 + $1.text }
    }
    
    private func sendPin() {
        if let pin = generatePin(), pin.count == numberOfPins {
            self.generatedPin = pin
        } else {
            self.generatedPin = ""
        }
    }
}
