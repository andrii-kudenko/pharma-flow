//
//  OrderConfirmationOverlay.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-17.
//

import SwiftUI
// MARK: - Improved Confirmation Overlay
struct OrderConfirmationOverlay: View {
    let confirmation: OrderConfirmation
    @ObservedObject private var cart = CartViewModel.shared

    var body: some View {
        ZStack {
            // Background blur
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    cart.confirmation = nil
                }
            
            VStack(spacing: 20) {
                // Success icon and header
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                    
                    Text("Order Placed")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.top, 10)
                
                Divider()
                
                // Order details in a grid-like layout
                VStack(spacing: 16) {
                    HStack(spacing: 0) {
                        Text("Order ID:")
                            .frame(width: 120, alignment: .leading)
                            .foregroundColor(.secondary)
                        
                        Text("\(confirmation.orderNumber)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.medium)
                    }
                    
                    HStack(spacing: 0) {
                        Text("Items:")
                            .frame(width: 120, alignment: .leading)
                            .foregroundColor(.secondary)
                        
                        Text("\(confirmation.totalItems)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.medium)
                    }
                    
                    HStack(spacing: 0) {
                        Text("Date:")
                            .frame(width: 120, alignment: .leading)
                            .foregroundColor(.secondary)
                        
                        Text("\(confirmation.createdAt.formatted(.dateTime))")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.medium)
                    }
                }
                .padding(.horizontal, 20)
                
                Divider()
                
                // Action button
                Button(action: {
                    cart.confirmation = nil
                }) {
                    Text("Continue Shopping")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
            .padding(.vertical, 20)
            .frame(width: min(UIScreen.main.bounds.width - 40, 400))
            .background(Color(.systemBackground))
            .ignoresSafeArea()
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 5)
        }
    }
}
#Preview {
    let confirmation = OrderConfirmation(id: UUID(uuidString: "079729ad-0877-4473-8a08-3816105f162b")!, orderNumber: "ORD-1744879203", totalItems: 6, createdAt: Date.now)
    OrderConfirmationOverlay(confirmation: confirmation )
}
