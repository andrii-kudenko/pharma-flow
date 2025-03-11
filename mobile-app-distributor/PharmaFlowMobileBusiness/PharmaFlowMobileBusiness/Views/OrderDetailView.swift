//
//  OrderDetailView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-10.
//

import SwiftUI

struct OrderDetailView: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Order Details").font(.largeTitle).bold()

            Text("Status: \(order.status.rawValue)").font(.title2)

            Text("Client: \(order.client.name) from \(order.client.company)")
            Text("Address: \(order.client.deliveryAddress)")
            Text("Phone: \(order.client.phone)")

            Text("Total Items: \(order.totalItems)")
            if let missing = order.missingItems {
                Text("Missing Items: \(missing)").foregroundColor(.red)
            } else {
                Text("All items in stock").foregroundColor(.green)
            }

            HStack {
                Button(action: {
                    // Logic to move order to previous stage
                }) {
                    Text("← Previous Stage")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // Logic to move order to next stage
                }) {
                    Text("Next Stage →")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.vertical)

            Spacer()
        }
        .padding()
    }
}
