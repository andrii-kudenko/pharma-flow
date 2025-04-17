//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item

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

                if let available = item.canBeOrdered {
                    Text(available ? "Available for Order" : "Currently Unavailable")
                        .font(.subheadline)
                        .foregroundColor(available ? .green : .red)
                        .padding(.top, 8)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Product Details")
    }
}

#Preview {
    var item = Item(
            id: UUID(),
            codeName: "Sodium Chloride",
            refNumber: "SC-100",
            gtin: "0123456789123",
            manufacturer: "PharmaCorp",
            description: "High-purity salt for medical use",
            officialUrl: "https://example.com",
            createdAt: Date(),
            canBeOrdered: true,
            priceUsd: 12.50
        )
    ItemDetailView(item: item)
}
