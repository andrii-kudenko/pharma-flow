//
//  CartViewModel.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-16.
//

import Foundation

class CartViewModel: ObservableObject {
    static let shared = CartViewModel()

    @Published private(set) var items: [(item: Item, quantity: Int)] = []

    private init() {}

    // Add item to cart with a specified quantity
    func add(item: Item, quantity: Int) {
        guard item.canBeOrdered == true, item.availableQuantity >= quantity else { return }

        if let index = items.firstIndex(where: { $0.item.id == item.id }) {
            let currentQty = items[index].quantity
            let maxAllowed = item.availableQuantity

            // Don't allow more than available quantity
            if currentQty + quantity <= maxAllowed {
                items[index].quantity += quantity
            } else {
                items[index].quantity = maxAllowed
            }
        } else {
            items.append((item: item, quantity: quantity))
        }
    }

    // Remove an item completely from the cart
    func remove(itemId: UUID) {
        items.removeAll { $0.item.id == itemId }
    }

    // Clear the entire cart
    func clear() {
        items.removeAll()
    }

    // Get quantity already in the cart for a given item
    func quantity(for item: Item) -> Int {
        return items.first(where: { $0.item.id == item.id })?.quantity ?? 0
    }

    // Total number of items in cart (sum of quantities)
    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    // Total cost of all items in cart
    var totalPrice: Decimal {
        items.reduce(0) { total, entry in
            total + (entry.item.priceUsd ?? 0) * Decimal(entry.quantity)
        }
    }

    // Build the backend order request body
    func toOrderRequest(clientId: UUID) -> CreateOrderRequest {
        let itemsList = items.map {
            OrderItemRequest(item_id: $0.item.id, quantity: $0.quantity)
        }
        return CreateOrderRequest(client_id: clientId, items: itemsList)
    }
}
