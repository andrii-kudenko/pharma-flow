//
//  ClientDetailView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-10.
//

import SwiftUI

struct ClientDetailView: View {
    let client: Client

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Client Details").font(.largeTitle).bold()

            Text("Name: \(client.name)").font(.title2)
            Text("Company: \(client.company)")
            Text("Total Orders: \(client.ordersCount)")
            Text("Last Order Date: \(client.lastOrderDate)")

            Text("Billing Address:")
                .font(.headline)
            Text(client.billingAddress)

            Text("Delivery Address:")
                .font(.headline)
            Text(client.deliveryAddress)

            Text("Contact Info:")
                .font(.headline)
            Text("Phone: \(client.phone)")
            Text("Email: \(client.email)")

            Spacer()
        }
        .padding()
    }
}
