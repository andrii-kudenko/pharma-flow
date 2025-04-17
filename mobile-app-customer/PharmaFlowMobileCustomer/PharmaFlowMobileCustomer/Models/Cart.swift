//
//  Cart.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-17.
//
import Foundation

struct Cart: Identifiable {
    let id: UUID
    let item: Item
    var quantity: Int
    
    init(item: Item, quantity: Int) {
        self.id = item.id
        self.item = item
        self.quantity = quantity
    }
}
