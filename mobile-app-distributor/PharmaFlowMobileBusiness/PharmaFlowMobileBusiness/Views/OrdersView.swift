//
//  OrdersView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-10.
//

import SwiftUI

struct OrdersView: View {
    @State private var searchText = ""
    @State private var selectedStatus: OrderStatus?

    let orders: [Order] = [
        Order(orderNumber: "ORD123", client: Client(name: "John Doe", company: "MediCorp", ordersCount: 10, lastOrderDate: "2025-03-09", phone: "123-456-7890", email: "john@example.com", billingAddress: "123 Main St", deliveryAddress: "456 Health Rd"), status: .new, lastUpdated: "Today", totalItems: 15, missingItems: nil),
        Order(orderNumber: "ORD124", client: Client(name: "Alice Smith", company: "PharmaPlus", ordersCount: 20, lastOrderDate: "2025-03-08", phone: "987-654-3210", email: "alice@example.com", billingAddress: "789 Wellness St", deliveryAddress: "321 Care Ave"), status: .processing, lastUpdated: "Yesterday", totalItems: 10, missingItems: 2)
    ]

    var filteredOrders: [Order] {
        orders.filter {
            (searchText.isEmpty || $0.client.company.lowercased().contains(searchText.lowercased())) &&
            (selectedStatus == nil || $0.status == selectedStatus)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search orders...", text: $searchText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)

                Picker("Filter by status", selection: $selectedStatus) {
                    Text("All").tag(OrderStatus?.none)
                    ForEach(OrderStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status as OrderStatus?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal)

                List(filteredOrders) { order in
                    NavigationLink(destination: OrderDetailView(order: order)) {
                        OrderCard(order: order)
                    }
                }
            }
            .navigationTitle("Orders")  
        }
    }
}


struct OrderCard: View {
    let order: Order

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.orderNumber).font(.headline)
                Text(order.client.company).font(.subheadline).foregroundColor(.gray)
                Text(order.status.rawValue).font(.caption).bold()
            }
            Spacer()
            Text(order.lastUpdated).font(.caption)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
