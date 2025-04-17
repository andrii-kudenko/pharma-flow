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
                    ProgressView("Loading Orders…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text(error).foregroundColor(.red)
                        Button("Retry") {
                            Task { await viewModel.loadOrders() }
                        }
                    }
                } else {
                    VStack(spacing: 10) {
                        // search bar
                        TextField("Search by order #", text: $viewModel.searchQuery)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                            .onChange(of: viewModel.searchQuery) { newValue in
                                viewModel.updateSearchQuery(newValue)
                            }

                        //
                        Picker("Filter", selection: Binding(
                            get: { viewModel.selectedStatus ?? "All" },
                            set: { viewModel.updateSelectedStatus($0 == "All" ? nil : $0) }
                        )) {
                            Text("All").tag("All")
                            Text("Pending").tag("pending")
                            Text("Confirmed").tag("confirmed")
                            Text("Shipped").tag("shipped")
                            Text("Completed").tag("completed")
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)

                        //Order List
                        List(viewModel.filteredOrders) { order in
                            NavigationLink {
                                OrderDetailView(orderId: order.id)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(order.order_number).font(.headline)
                                    Text(order.client_name).font(.subheadline)
                                    Text(order.status.capitalized)
                                        .font(.caption)
                                        .foregroundColor(order.status.statusColor())
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 2)
                                        .background(order.status.statusColor().opacity(0.1))
                                        .cornerRadius(5)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .listStyle(.insetGrouped)
                        .refreshable {
                            await viewModel.loadOrders()
                        }
                    }
                }
            }
            .navigationTitle("All Orders")
        }
        .task {
            await viewModel.loadOrders()
        }
    }
}
