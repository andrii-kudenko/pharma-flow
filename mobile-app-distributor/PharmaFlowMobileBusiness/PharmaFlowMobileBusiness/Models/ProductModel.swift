//
//  ProductModel.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-10.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let certificate: String
    let quantity: Int
}
