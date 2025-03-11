//
//  ClientsView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-10.
//

import SwiftUI

struct ClientsView: View {
    let clients: [Client] = [
        Client(name: "John Doe", company: "MediCorp", ordersCount: 10, lastOrderDate: "2025-03-09", phone: "123-456-7890", email: "john@example.com", billingAddress: "123 Main St", deliveryAddress: "456 Health Rd"),
        Client(name: "Alice Smith", company: "PharmaPlus", ordersCount: 20, lastOrderDate: "2025-03-08", phone: "987-654-3210", email: "alice@example.com", billingAddress: "789 Wellness St", deliveryAddress: "321 Care Ave")
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Clients")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)

                List(clients) { client in
                    NavigationLink(destination: ClientDetailView(client: client)) {
                        ClientCard(client: client)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("Clients")
        }
    }
}


struct ClientCard: View {
    let client: Client

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(client.name).font(.headline)
                Text(client.company).font(.subheadline).foregroundColor(.gray)
                Text("Orders: \(client.ordersCount)").font(.caption).bold()
            }
            Spacer()
            Text(client.lastOrderDate).font(.caption)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
