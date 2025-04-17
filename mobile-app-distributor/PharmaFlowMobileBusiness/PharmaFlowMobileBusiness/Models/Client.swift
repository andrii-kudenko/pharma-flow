//
//  Client.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-04-17.
//
import Foundation

struct ClientSummary: Identifiable, Decodable {
    let id: UUID?
    let name: String
    let company_name: String
    let last_order_date: String?
    
}

struct Client: Identifiable, Decodable {
    var id = UUID()
    let name: String
    let company: String
    let ordersCount: Int
    let lastOrderDate: String
    let phone: String
    let email: String
    let billingAddress: String
    let deliveryAddress: String
}

struct ClientDetails: Identifiable, Decodable {
    var id = UUID()
    let f_name: String
    let l_name: String
    let email: String
    let phone: String?
    let company_name: String?
    let orders_count: Int
    let billing_address: String?
    let delivery_address: String?
}




