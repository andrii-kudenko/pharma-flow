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
    let items: [Item] // Changed from Product to Item
    let note: String?
}

struct CreateOrderRequest: Codable {
    let clientId: UUID
    let items: [OrderItemRequest]
    
    // Using camelCase in Swift but sending snake_case to API
    // This is handled by JSONEncoder's keyEncodingStrategy now
}

struct OrderItemRequest: Codable {
    let itemId: UUID
    let quantity: Int
    
    // Using camelCase in Swift but sending snake_case to API
    // This is handled by JSONEncoder's keyEncodingStrategy now
}

struct OrderConfirmation: Codable, Identifiable {
    let id: UUID
    let orderNumber: String
    let totalItems: Int
    let createdAt: Date
    
    // Using camelCase in Swift but receiving snake_case from API
    // This is handled by JSONDecoder's keyDecodingStrategy now
}

enum OrderError: Error, LocalizedError {
    case serverError(String)
    case insufficientStock(String)

    var errorDescription: String? {
        switch self {
        case .serverError(let msg): return "Server Error: \(msg)"
        case .insufficientStock(let msg): return "Insufficient Stock: \(msg)"
        }
    }
}
