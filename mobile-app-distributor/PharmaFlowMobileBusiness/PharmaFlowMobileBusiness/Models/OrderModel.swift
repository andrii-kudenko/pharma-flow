//
//  OrderModel.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-10.
//

import Foundation

struct Order: Identifiable {
    let id = UUID()
    let orderNumber: String
    let client: Client
    let status: OrderStatus
    let lastUpdated: String
    let totalItems: Int
    let missingItems: Int?
}

enum OrderStatus: String, CaseIterable {
    case new = "New"
    case scheduled = "Scheduled"
    case confirmed = "Confirmed"
    case processing = "Processing"
    case stockIssues = "Stock Issues"
    case readyForShipment = "Ready for Shipment"
    case shipped = "Shipped"
    case inTransit = "In Transit"
    case delivered = "Delivered"
    case delayed = "Delayed"
    case cancelled = "Cancelled"
}


//MARK: Used for OrderViews 
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


struct OrderStatusSummary: Decodable {
    let pending: Int
    let confirmed: Int
    let shipped: Int
    let completed: Int
}
