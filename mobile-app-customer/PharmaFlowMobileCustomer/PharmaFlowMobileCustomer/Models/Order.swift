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
