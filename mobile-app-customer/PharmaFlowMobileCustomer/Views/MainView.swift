//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ItemCatalogView()
                .tabItem {
                    Label("Catalog", systemImage: "list.bullet")
                }
            
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
            
            OrdersView()
                .tabItem{
                    Label("Orders", systemImage: "shippingbox.fill")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
    }
}
