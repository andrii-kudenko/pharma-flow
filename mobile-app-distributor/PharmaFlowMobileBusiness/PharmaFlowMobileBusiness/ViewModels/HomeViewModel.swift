//
//  HomeViewModel.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-04-17.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var summary: OrderStatusSummary?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadSummary() async {
        isLoading = true
        do {
            summary = try await OrderService.shared.fetchOrderStatusSummary()
        } catch {
            errorMessage = "Failed to load summary: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
