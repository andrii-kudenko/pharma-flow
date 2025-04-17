//
//  PharmaFlowMobileBusinessApp.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-02.
//

import SwiftUI

@main
struct PharmaFlowMobileBusinessApp: App {
    @State private var isLoggedIn = false
    @State private var username: String = ""

    var body: some Scene {
        WindowGroup {
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    
                    OrdersView()
                        .tabItem {
                            Image(systemName: "list.bullet.rectangle")
                            Text("Orders")
                        }
                    
                    ClientsView()
                        .tabItem {
                            Image(systemName: "person.3.fill")
                            Text("Clients")
                        }

                    ProductsView()
                        .tabItem {
                            Image(systemName: "capsule.fill")
                            Text("Products")
                        }
                    ItemCatalogView()
                        .tabItem {
                            Image(systemName: "pills.circle.fill")
                            Text("Items")
                        }
                }
        }
    }
}



