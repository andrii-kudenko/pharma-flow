//
//  OrdersView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-17.
//
import SwiftUI

struct OrdersView: View {
    @StateObject private var viewModel = OrdersViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoadingList {
                    ProgressView("Loading Orders...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text(error).foregroundColor(.red)
                        Button("Retry") {
                            Task { await viewModel.loadOrders() }
                        }
                    }
                } else if viewModel.allOrders.isEmpty {
                    Text("No orders available.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.allOrders) { order in
                        NavigationLink {
                            OrderDetailView(orderId: order.id)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(order.order_number).font(.headline)
                                Text(order.client_name).font(.subheadline)
                                Text(order.status.capitalized)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("All Orders")
        }
        .task {
            await viewModel.loadOrders()
        }
    }
}

#Preview {
    NavigationStack {
        OrdersViewPreviewWrapper()
    }
}

struct OrdersViewPreviewWrapper: View {
    @StateObject var mockViewModel = OrdersViewModel()

    var body: some View {
        OrdersView()
            .environmentObject(mockViewModel)
            .task {
                mockViewModel.allOrders = [
                    OrderSummary(
                        id: UUID(),
                        order_number: "ORD-1713367852",
                        status: "pending",
                        client_name: "John Doe",
                        company_name: "HealthPlus Inc."
                    ),
                    OrderSummary(
                        id: UUID(),
                        order_number: "ORD-1713367999",
                        status: "shipped",
                        client_name: "Jane Smith",
                        company_name: "BioPharma Ltd."
                    )
                ]
            }
    }
}
