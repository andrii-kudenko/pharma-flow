//
//  Product.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let availability: String
    let price: String
    let description: String
}
