//
//  PinView.swift
//  SwiftUIPinView
//

import SwiftUI

struct PinView: View {
    // MARK: - Private Properties
    private let spacing: CGFloat = 20
    
    // MARK: - Public Properties
    @StateObject public var viewModel: PinViewViewModel
    public var onPinReceive: ((String) -> Void)
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(viewModel.pinViewItems) { item in
                PinTextField(viewItem: item, onTextChange: { value in
                    viewModel.textFieldTextChange(replacementText: value, viewItem: item)
                }, onBackPressed: { item in
                    viewModel.onTextFieldBackPressed(viewItem: item)
                })
                .modifier(RoundedBorderModifier(borderColor: viewModel.isError ? Color.red : Color.gray))
                .frame(height: pinSize)
                .frame(width: pinSize)
            }
        }.onReceive(viewModel.$dismissAllKeyboard) { value in
            if value {
                hideKeyboard()
            }
        }
        .onReceive(viewModel.$generatedPin) { newValue in
            onPinReceive(newValue)
        }
    }
    
    private var pinSize: CGFloat {
        return (UIScreen.main.bounds.size.width - (spacing *  CGFloat(viewModel.getNumberOfPins()))) / CGFloat(viewModel.getNumberOfPins())
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    #imageLiteral(resourceName: "simulator_screenshot_D3D2957C-8732-498B-868D-14AC33008832.png")
}
