//
//  OrdersViewModel.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-17.
//

import Foundation

@MainActor
class OrdersViewModel: ObservableObject {
    @Published var allOrders: [OrderSummary] = []
    @Published var selectedOrder: OrderDetails?

    @Published var isLoadingList = false
    @Published var isLoadingDetails = false
    @Published var errorMessage: String?

    func loadOrders() async {
        isLoadingList = true
        errorMessage = nil
        defer { isLoadingList = false }

        do {
            allOrders = try await OrderService.shared.fetchAllOrders()
        } catch {
            errorMessage = "Failed to load orders: \(error.localizedDescription)"
        }
    }

    func loadOrderDetails(for id: UUID) async {
        isLoadingDetails = true
        errorMessage = nil
        defer { isLoadingDetails = false }

        do {
            selectedOrder = try await OrderService.shared.fetchOrderDetails(id: id)
        } catch {
            errorMessage = "Failed to load order details: \(error.localizedDescription)"
        }
    }

    func clearSelection() {
        selectedOrder = nil
    }

    func clearError() {
        errorMessage = nil
    }
}
