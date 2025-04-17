//
//  CartViewModel.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-16.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    static let shared = CartViewModel()
    
    // MARK: - Published Properties
    @Published var items: [Cart] = []
    @Published var isPlacingOrder = false
    @Published var confirmation: OrderConfirmation? = nil
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    private init() {}
    
    // MARK: - Order Placement
    func placeOrder(clientId: UUID) async {
        guard !items.isEmpty else { return }
        
        isPlacingOrder = true
        
        // Before placing order, verify that all items are still in stock
        for cartItem in items {
            if cartItem.quantity > cartItem.item.availableQuantity {
                errorMessage = "Not enough \(cartItem.item.codeName) in stock. Only \(cartItem.item.availableQuantity) available."
                showError = true
                isPlacingOrder = false
                return
            }
        }
        
        do {
            let request = createOrderRequest(clientId: clientId)
            let result = try await OrderService.shared.submitOrder(request: request)
            confirmation = result
            clear()
        } catch let error as OrderError {
            errorMessage = error.localizedDescription
            showError = true
        } catch {
            errorMessage = "Failed to place order: \(error.localizedDescription)"
            showError = true
        }
        
        isPlacingOrder = false
    }
    
    // MARK: - Cart Management
    
    // Add item to cart with a specified quantity
    func add(item: Item, quantity: Int) {
        guard quantity > 0 else { return }
        guard item.canBeOrdered == true, item.availableQuantity > 0 else { return }
        
        let safeQuantity = min(quantity, item.availableQuantity)
        
        if let index = items.firstIndex(where: { $0.item.id == item.id }) {
            let currentQty = items[index].quantity
            let maxAllowed = item.availableQuantity
            
            // Don't allow more than available quantity
            items[index].quantity = min(currentQty + safeQuantity, maxAllowed)
        } else {
            items.append(Cart(item: item, quantity: safeQuantity))
        }
    }
    
    // Update quantity for an item
    func updateQuantity(itemId: UUID, quantity: Int) {
        guard quantity > 0 else {
            remove(itemId: itemId)
            return
        }
        
        if let index = items.firstIndex(where: { $0.item.id == itemId }) {
            let item = items[index].item
            let maxAllowed = item.availableQuantity
            
            items[index].quantity = min(quantity, maxAllowed)
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
    func quantity(for itemId: UUID) -> Int {
        return items.first(where: { $0.item.id == itemId })?.quantity ?? 0
    }
    
    // MARK: - Computed Properties
    
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
    
    // MARK: - Helper Methods
    
    // Build the backend order request body
    private func createOrderRequest(clientId: UUID) -> CreateOrderRequest {
        let itemsList = items.map {
            OrderItemRequest(itemId: $0.item.id, quantity: $0.quantity)
        }
        return CreateOrderRequest(clientId: clientId, items: itemsList)
    }
}
