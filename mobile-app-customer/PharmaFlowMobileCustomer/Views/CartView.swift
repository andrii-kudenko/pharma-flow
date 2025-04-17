//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//
import SwiftUI

struct CartView: View {
    @ObservedObject private var cart = CartViewModel.shared

    // TEMP: Replace this with actual client ID when using auth
    let fakeClientId = UUID(uuidString: "079729ad-0877-4473-8a08-3816105f162b")!

    var body: some View {
        NavigationView {
            VStack {
                if cart.items.isEmpty {
                    EmptyCartView()
                } else {
                    CartItemsList()
                    CartFooter(clientId: fakeClientId)
                }
            }
            .navigationTitle("Cart")
            .overlay {
                if let confirmation = cart.confirmation {
                    OrderConfirmationOverlay(confirmation: confirmation).animation(.easeInOut)
                }
            }
            .alert("Order Failed ❌", isPresented: $cart.showError) {
                Button("OK") { cart.showError = false }
            } message: {
                Text(cart.errorMessage)
            }
        }
    }
}

// MARK: - Empty State View
private struct EmptyCartView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("🛒 Your cart is empty")
                .foregroundColor(.gray)
                .font(.title3)
            Spacer()
        }
    }
}

// MARK: - Cart Items List
private struct CartItemsList: View {
    @ObservedObject private var cart = CartViewModel.shared

    var body: some View {
        List {
            ForEach(cart.items, id: \.id) { entry in
                CartItemRow(entry: entry)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let itemId = cart.items[index].item.id
                    cart.remove(itemId: itemId)
                }
            }
        }
    }
}

// MARK: - Single Cart Item Row
private struct CartItemRow: View {
    let entry: Cart

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.item.codeName)
                .font(.headline)

            Text("Qty: \(entry.quantity)")
                .foregroundColor(.secondary)

            if let price = entry.item.priceUsd {
                let subtotal = price * Decimal(entry.quantity)
                Text("Subtotal: $\(subtotal)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Footer with Place Order Button
private struct CartFooter: View {
    @ObservedObject private var cart = CartViewModel.shared
    let clientId: UUID

    var body: some View {
        VStack(spacing: 12) {
            Text("Total: $\(cart.totalPrice)")
                .font(.title2)
                .bold()

            Button(action: {
                Task { await cart.placeOrder(clientId: clientId) }
            }) {
                if cart.isPlacingOrder {
                    ProgressView()
                        .frame(height: 20)
                } else {
                    Text("Place Order")
                        .bold()
                        .frame(height: 20)
                }
            }
            .frame(minWidth: 200)
            .disabled(cart.isPlacingOrder)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}


#Preview {
    CartView()
}
