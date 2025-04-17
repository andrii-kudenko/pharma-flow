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

struct OrderConfirmation: Codable, Identifiable, Equatable {
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

//MARK: Used for ViewAll Orders and ViewOrderDetails

struct OrderSummary: Identifiable, Decodable {
    let id: UUID
    let order_number: String
    let status: String
    let client_name: String
    let company_name: String
}

struct OrderDetails: Identifiable, Decodable {
    let id: UUID
    let order_number: String
    let status: String
    let client_name: String
    let company_name: String
    let delivery_address: String
    let total_items: Int
    let total_price: Double
    let products: [ProductInfo]
}

struct ProductInfo: Decodable {
    let code_name: String
    let description: String
    let quantity: Int
    let price_per_unit: Double
}
