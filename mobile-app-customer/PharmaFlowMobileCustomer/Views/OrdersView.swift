//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct OrdersView: View {
    let orders = [
        Order(
            date: "2025-03-04",
            numProducts: 2,
            totalPrice: "$15",
            items: [
                Product(name: "Gloves", availability: "In Stock", price: "$10", description: "Disposable medical gloves."),
                Product(name: "Mask", availability: "In Stock", price: "$5", description: "Surgical protective mask.")
            ],
            note: "Urgent delivery required."
        ),
        Order(
            date: "2025-02-28",
            numProducts: 3,
            totalPrice: "$50",
            items: [
                Product(name: "Thermometer", availability: "In Stock", price: "$25", description: "Digital thermometer."),
                Product(name: "Gloves", availability: "In Stock", price: "$10", description: "Disposable medical gloves."),
                Product(name: "Face Shield", availability: "In Stock", price: "$15", description: "Protective face shield.")
            ],
            note: nil
        )
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Previous Orders")
                    .font(.largeTitle)
                    .padding()

                List(orders) { order in
                    NavigationLink(destination: OrderDetailView(order: order)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Order Date: \(order.date)")
                                    .font(.headline)
                                Text("Products: \(order.numProducts)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(order.totalPrice)
                                .font(.headline)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

