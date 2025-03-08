//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct OrderDetailView: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Order Date: \(order.date)")
                .font(.headline)
            
            Text("Number of Products: \(order.numProducts)")
            
            Text("Total Price: \(order.totalPrice)")
                .font(.headline)
                .padding(.bottom)

            Text("Ordered Items:")
                .font(.headline)
            
            List(order.items) { product in
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    Text("Price: \(product.price)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }

            if let note = order.note {
                Text("Order Note:")
                    .font(.headline)
                    .padding(.top)
                Text(note)
                    .italic()
                    .foregroundColor(.gray)
            }

            Spacer()

            Button(action: {}) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add to Cart")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}
