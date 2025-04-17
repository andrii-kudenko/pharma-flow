//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item

    @State private var quantity: Int = 1
    @State private var showAddedMessage = false
    @ObservedObject private var cart = CartViewModel.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(item.codeName)
                    .font(.title)
                    .fontWeight(.bold)

                if let price = item.priceUsd {
                    Text("$\(price)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }

                Text("Manufacturer: \(item.manufacturer)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                if let description = item.description {
                    Text(description)
                        .font(.body)
                        .padding(.top, 8)
                }

                if let url = item.officialUrl, let link = URL(string: url) {
                    Link("More Info", destination: link)
                        .padding(.top, 8)
                }

                // Availability
                if item.availableQuantity > 0 {
                    Text("In Stock: \(item.availableQuantity)")
                        .font(.subheadline)
                        .foregroundColor(.green)
                } else {
                    Text("Out of Stock")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }

                if let available = item.canBeOrdered {
                    Text(available ? "Available for Order" : "Not Available for Order")
                        .font(.subheadline)
                        .foregroundColor(available ? .green : .gray)
                }

                // Cart interaction
                if item.canBeOrdered == true && item.availableQuantity > 0 {
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 1...item.availableQuantity)

                    Button("Add to Cart") {
                        cart.add(item: item, quantity: quantity)
                        showAddedMessage = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 8)

                    if showAddedMessage {
                        Text("✅ Added to cart!")
                            .foregroundColor(.green)
                            .font(.footnote)
                    }
                } else {
                    Text("Cannot add to cart")
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Product Details")
    }
}


#Preview {
    let item = Item(
            id: UUID(),
            codeName: "Sodium Chloride",
            manufacturer: "PharmaCorp",
            description: "High-purity salt for medical use",
            officialUrl: "https://example.com",
            canBeOrdered: true,
            priceUsd: 12.50,
            availableQuantity: 12
        )
    ItemDetailView(item: item)
}
