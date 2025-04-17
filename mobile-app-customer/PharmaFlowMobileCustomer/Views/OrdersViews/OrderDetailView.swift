//
//  OrderDetailView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-17.
//
import SwiftUI

struct OrderDetailView: View {
    let orderId: UUID
    @StateObject private var viewModel = OrderDetailViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading Order Details...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text(error).foregroundColor(.red)
                    Button("Retry") {
                        Task { await viewModel.loadDetails(for: orderId) }
                    }
                }
            } else if let order = viewModel.orderDetails {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Group {
                            Text("Order #: \(order.order_number)").font(.title2).bold()
                            Text("Status: \(order.status)").foregroundColor(.blue)
                            Divider()

                            Text("Client: \(order.client_name)")
                            Text("Company: \(order.company_name)")
                            Text("Delivery Address:")
                            Text(order.delivery_address).font(.subheadline)
                        }

                        Divider()

                        Text("Items").font(.headline)
                        ForEach(order.products.indices, id: \.self) { index in
                            let product = order.products[index]
                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.code_name).font(.subheadline).bold()
                                Text(product.description).font(.caption)
                                Text("Qty: \(product.quantity)")
                                Text("Unit Price: $\(product.price_per_unit, specifier: "%.2f")")
                            }
                            .padding(.vertical, 6)

                            if index < order.products.count - 1 {
                                Divider()
                            }
                        }

                        Divider()

                        HStack {
                            Text("Total Items:")
                            Spacer()
                            Text("\(order.total_items)")
                        }

                        HStack {
                            Text("Total Price:")
                            Spacer()
                            Text("$\(order.total_price, specifier: "%.2f")")
                        }
                        .font(.headline)

                    }
                    .padding()
                }
            } else {
                Text("Order not found").foregroundColor(.gray)
            }
        }
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDetails(for: orderId)
        }
    }
}

#Preview {
    NavigationStack {
        OrderDetailViewPreviewWrapper()
    }
}

struct OrderDetailViewPreviewWrapper: View {
    @StateObject var mockDetailVM = OrderDetailViewModel()

    var body: some View {
        OrderDetailView(orderId: UUID())
            .environmentObject(mockDetailVM)
            .task {
                mockDetailVM.orderDetails = OrderDetails(
                    id: UUID(),
                    order_number: "ORD-1713367852",
                    status: "pending",
                    client_name: "John Doe",
                    company_name: "HealthPlus Inc.",
                    delivery_address: "123 Medical St, Toronto, ON",
                    total_items: 12,
                    total_price: 243.60,
                    products: [
                        ProductInfo(code_name: "Amox-500", description: "Amoxicillin 500mg Capsules", quantity: 6, price_per_unit: 12.5),
                        ProductInfo(code_name: "Cetraxal", description: "Ear Drops - Antibiotic", quantity: 6, price_per_unit: 28.1)
                    ]
                )
            }
    }
}
