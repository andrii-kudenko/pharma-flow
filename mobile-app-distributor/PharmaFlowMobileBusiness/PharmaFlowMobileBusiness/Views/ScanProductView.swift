//
//  ScanProductView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Nicholas Sullivan on 2025-03-10.
//

import SwiftUI

struct ScanProductView: View {
    let username: String
    @Binding var isNavigatedToHome: Bool // Tracks navigation back to HomeView
    @State private var isNavigatedToUpdate: Bool = false // Tracks navigation to UpdateProductView

    var body: some View {
        VStack {
            Image("Camera")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
                .clipped()

            Spacer()

            NavigationLink(
                destination: UpdateProductView(isNavigatedToHome: $isNavigatedToHome, username: username),
                isActive: $isNavigatedToUpdate
            ) {
                Text("Take Picture")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
            }
        }
        .background(Color.black)
        .navigationTitle("Scan Product")
        .navigationBarBackButtonHidden(false)
    }
}


#Preview {
    ScanProductView(username: "User", isNavigatedToHome: .constant(true))
}

