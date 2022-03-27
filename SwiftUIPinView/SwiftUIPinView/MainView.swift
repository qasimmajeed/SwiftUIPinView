//
//  MainView.swift
//  SwiftUIPinView
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView{
            VStack {
                PinView(viewModel: PinViewViewModel(numberOfPins: 4, isFocusOnStart: true)) { pinCode in
                    print("pin code received", pinCode)
                }
                Spacer()
                Text("created by lambda")
                    .font(.subheadline)
                    .foregroundColor(.gray.opacity(0.4))
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .top)
            .padding(.top, 20)
            .navigationTitle("SwiftUI PinView")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
