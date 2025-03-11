//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(product.name)
                .font(.largeTitle)
                .bold()
            
            Text(product.description)
                .font(.body)

            Text("Sample Certificate: Available")
                .foregroundColor(.blue)

            Text("Price: \(product.price)")
                .font(.headline)

            Spacer()
            
            Button(action: {}) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add to Cart")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
    }
}
