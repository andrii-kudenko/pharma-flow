//
//  ClientModel.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-10.
//

import Foundation

struct Client: Identifiable {
    let id = UUID()
    let name: String
    let company: String
    let ordersCount: Int
    let lastOrderDate: String
    let phone: String
    let email: String
    let billingAddress: String
    let deliveryAddress: String
}
