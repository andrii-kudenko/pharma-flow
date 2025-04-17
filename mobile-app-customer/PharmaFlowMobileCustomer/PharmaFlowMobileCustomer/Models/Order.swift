//
//  Order.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import Foundation

struct Order: Identifiable {
    let id = UUID()
    let date: String
    let numProducts: Int
    let totalPrice: String
    let items: [Product]
    let note: String?
}

struct CreateOrderRequest: Codable {
    let client_id: UUID
    let items: [OrderItemRequest]
}

struct OrderItemRequest: Codable {
    let item_id: UUID
    let quantity: Int
}

struct OrderConfirmation: Codable {
    let id: UUID
    let order_number: String
    let total_items: Int
    let created_at: Date
}

enum OrderError: Error, LocalizedError {
    case serverError(String)

    var errorDescription: String? {
        switch self {
        case .serverError(let msg): return "Server Error: \(msg)"
        }
    }
}
