//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//
import SwiftUI

struct CartView: View {
    @ObservedObject private var cart = CartViewModel.shared
    @State private var isPlacingOrder = false
    @State private var showSuccess = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    // TEMP: Replace this with actual client ID when using auth
    let fakeClientId = UUID()

    var body: some View {
        NavigationView {
            VStack {
                if cart.items.isEmpty {
                    Spacer()
                    Text("🛒 Your cart is empty")
                        .foregroundColor(.gray)
                        .font(.title3)
                    Spacer()
                } else {
                    List {
                        ForEach(cart.items, id: \.item.id) { entry in
                            VStack(alignment: .leading) {
                                Text(entry.item.codeName)
                                    .font(.headline)
                                
                                Text("Qty: \(entry.quantity)")
                                if let price = entry.item.priceUsd {
                                    Text("Subtotal: $\(price * Decimal(entry.quantity))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let itemId = cart.items[index].item.id
                                cart.remove(itemId: itemId)
                            }
                        }
                    }
                    
                    VStack(spacing: 12) {
                        Text("Total: $\(cart.totalPrice)")
                            .font(.title2)
                            .bold()
                        
                        Button(action: placeOrder) {
                            if isPlacingOrder {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                Text("Place Order")
                                    .bold()
                            }
                        }
                        .disabled(isPlacingOrder)
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .navigationTitle("Cart")
            .alert("Order Placed ✅", isPresented: $showSuccess) {
                Button("OK") { }
            } message: {
                Text("Your order was successfully placed.")
            }
            .alert("Order Failed ❌", isPresented: $showError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }

    private func placeOrder() {
        Task {
            isPlacingOrder = true
            do {
                let orderRequest = cart.toOrderRequest(clientId: fakeClientId)
                let _ = try await OrderService.shared.submitOrder(request: orderRequest)
                cart.clear()
                showSuccess = true
            } catch {
                errorMessage = error.localizedDescription
                showError = true
            }
            isPlacingOrder = false
        }
    }
}

#Preview {
    CartView()
}
