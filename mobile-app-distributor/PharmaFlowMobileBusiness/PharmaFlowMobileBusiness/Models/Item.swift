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
    let refNumber: String?
    let gtin: String?
    let manufacturer: String
    let description: String?
    let officialUrl: String?
    let createdAt: Date?
    let canBeOrdered: Bool?
    let priceUsd: Decimal?

    enum CodingKeys: String, CodingKey {
        case id
        case codeName = "code_name"
        case refNumber = "ref_number"
        case gtin
        case manufacturer
        case description
        case officialUrl = "official_url"
        case createdAt = "created_at"
        case canBeOrdered = "can_be_ordered"
        case priceUsd = "price_usd"
    }
}
