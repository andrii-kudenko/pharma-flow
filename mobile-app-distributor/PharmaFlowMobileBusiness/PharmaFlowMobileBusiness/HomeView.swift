//
//  HomeView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Nicholas Sullivan on 2025-03-10.
//

import SwiftUI

struct HomeView: View {
    let username: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome \(username)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Stock Section
                    stockSection

                    // Deliveries Section
                    deliveriesSection
                }
            }
        }
    }

    private var stockSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Stock Levels")
                .font(.title2)
                .padding(.horizontal)
            
            ForEach(mockStockData, id: \.product) { item in
                HStack {
                    Text(item.product)
                    Spacer()
                    Text("\(item.stock) units")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            }
            
            NavigationLink(destination: ScanProductView()) {
                Text("Add Stock")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }

    private var deliveriesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Incoming Deliveries")
                .font(.title2)
                .padding(.horizontal)
            
            ForEach(mockDeliveryData, id: \.id) { delivery in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Delivery \(delivery.id)")
                            .fontWeight(.bold)
                        Text("Details: \(delivery.details)")
                        Text("Date: \(delivery.date)")
                        Text("Status: \(delivery.status)")
                        Text("Quantity: \(delivery.quantity)")
                    }
                    Spacer()
                    statusIcon(for: delivery.status)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
    }

    private func statusIcon(for status: String) -> some View {
        let imageName: String
        switch status {
        case "Pending":
            imageName = "clock.fill"
        case "In Transit":
            imageName = "cube.box.fill"
        case "Delivered":
            imageName = "checkmark.circle.fill"
        default:
            imageName = "questionmark.circle.fill"
        }
        return Image(systemName: imageName)
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(.blue)
    }
}

// Mock data for stock levels
struct StockItem: Identifiable {
    let id = UUID()
    let product: String
    let stock: Int
}

let mockStockData = [
    StockItem(product: "Product A", stock: 50),
    StockItem(product: "Product B", stock: 20),
    StockItem(product: "Product C", stock: 75)
]

// Mock data for deliveries
struct Delivery: Identifiable {
    let id: Int
    let details: String
    let date: String
    let status: String
    let quantity: Int
}

let mockDeliveryData = [
    Delivery(id: 1, details: "Delivery of Product A", date: "2025-03-15", status: "Pending", quantity: 100),
    Delivery(id: 2, details: "Delivery of Product B", date: "2025-03-18", status: "In Transit", quantity: 200),
    Delivery(id: 3, details: "Delivery of Product C", date: "2025-03-20", status: "Delivered", quantity: 150)
]

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(username: "User")
    }
}


