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
