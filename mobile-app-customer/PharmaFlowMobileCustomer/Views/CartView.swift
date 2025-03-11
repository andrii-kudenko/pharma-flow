//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct CartView: View {
    @State private var cartItems = [
        Product(name: "Gloves", availability: "In Stock", price: "$10", description: "Disposable medical gloves."),
        Product(name: "Mask", availability: "In Stock", price: "$5", description: "Surgical protective mask.")
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Cart")
                    .font(.largeTitle)
                    .padding()

                List {
                    ForEach(cartItems) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                Text("Price: \(product.price)")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {
                                cartItems.removeAll { $0.id == product.id }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Add a Note to the Order:")
                        .font(.subheadline)
                    TextField("Enter a note...", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom)

                    Button(action: {}) {
                        Text("Place Order")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }
}
