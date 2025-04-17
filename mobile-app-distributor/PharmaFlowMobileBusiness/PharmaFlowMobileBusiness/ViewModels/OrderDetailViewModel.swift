//
//  OrderDetailViewModel.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-17.
//
import Foundation

@MainActor
class OrderDetailViewModel: ObservableObject {
    @Published var orderDetails: OrderDetails?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadDetails(for orderId: UUID) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            orderDetails = try await OrderService.shared.fetchOrderDetails(id: orderId)
        } catch {
            errorMessage = "Failed to load order details: \(error.localizedDescription)"
        }
    }

    func clear() {
        orderDetails = nil
        errorMessage = nil
    }
}
