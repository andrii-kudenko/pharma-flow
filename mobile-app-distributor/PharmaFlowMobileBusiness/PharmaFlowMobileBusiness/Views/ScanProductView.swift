//
//  ScanProductView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Nicholas Sullivan on 2025-03-10.
//

import SwiftUI

struct ScanProductView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("Camera")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7) // Adjusted height
                    .clipped()

                Spacer() // Pushes button up

                NavigationLink(destination: AddProductView()) {
                    Text("Take Picture")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 80)
                }
            }
            .background(Color.black)
            .navigationTitle("Scan Product")
            .navigationBarBackButtonHidden(false) // ✅ Back button added
        }
        .ignoresSafeArea(.all, edges: .bottom) 
    }
}

#Preview {
    ScanProductView()
}

