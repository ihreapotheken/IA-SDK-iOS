//
//  IACartButtonExamples.swift
//  MainExample
//
//  Created by Danijel Huis on 15.04.2026..
//

import SwiftUI
import IACore

struct IACartButtonExampleScreen: View {
    let onDismiss: () -> Void
    @State private var showDebugAlert = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Text("This is host app screen with embedded IACartButtons.\n\nThe button displays the current cart item count and navigates to the cart screen when tapped.")
                        .fixedSize(horizontal: false, vertical: true)
                    Divider()

                    VStack {
                        Text("This cart button does not provide onTap callback, meaning SDK will call delegate and allow host app to override cart button tap in the delegate.")
                            .fixedSize(horizontal: false, vertical: true)

                        IACartButton()

                        Text("This cart button provides onTap callback, meaning host app is responsible on the spot what to do with the event.")
                            .fixedSize(horizontal: false, vertical: true)

                        IACartButton() {
                            showDebugAlert = true
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(24)
            }
            .background(.ia.screenBg)
            .navigationTitle("IACartButton")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { onDismiss() } label: { Image(systemName: "xmark") }
                }
            }
            .alert("Debug Info", isPresented: $showDebugAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Host app received cart button event!")
            }
        }
    }
}
