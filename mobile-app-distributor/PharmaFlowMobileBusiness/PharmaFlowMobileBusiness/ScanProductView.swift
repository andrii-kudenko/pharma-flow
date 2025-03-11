//
//  ScanProductView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Nicholas Sullivan on 2025-03-10.
//

import SwiftUI

struct ScanProductView: View {
    var body: some View {
        VStack {
            Image("Camera")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 400, height: 700)
                .clipped()
            NavigationLink(destination: AddProductView()) {
                Text("Take Picture")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }.padding()
        .background(Color.black)
    }
}

#Preview {
    ScanProductView()
}
