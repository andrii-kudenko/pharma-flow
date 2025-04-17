//
//  Item.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-16.
//

import Foundation

struct Item: Identifiable, Codable {
    let id: UUID
    let codeName: String
    let manufacturer: String
    let description: String?
    let officialUrl: String?
    let canBeOrdered: Bool?
    let priceUsd: Decimal?
    let availableQuantity: Int

    enum CodingKeys: String, CodingKey {
        case id
        case codeName = "code_name"
        case manufacturer
        case description
        case officialUrl = "official_url"
        case canBeOrdered = "can_be_ordered"
        case priceUsd = "price_usd"
        case availableQuantity = "available_quantity"
    }
}
