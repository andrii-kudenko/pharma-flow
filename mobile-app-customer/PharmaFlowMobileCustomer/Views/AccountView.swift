//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack {
            Text("Account Information")
                .font(.largeTitle)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Company: ABC Corp")
                Text("Employee: John Doe")
                Text("Email: johndoe@example.com")
                Text("Billing Address: 123 Main St")
                Text("Delivery Address: 456 Elm St")
                Text("Phone: +1 234 567 8900")
            }
            .padding()
        }
    }
}
