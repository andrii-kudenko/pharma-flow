//
//  HomeView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Nicholas Sullivan on 2025-03-10.
//

import SwiftUI

struct HomeView: View {
    let username: String
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("Welcome, \(username) 👋")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 16) {
                       
                        dashboardSection
                        
                        Divider()
                            .padding(.horizontal)
                            .padding(30)
                        
                        
                        quickActionsSection
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
    

    private var dashboardSection: some View {
        VStack {
            Text("Notifications")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top, 20)
            HStack(spacing: 10) {
                DashboardCard(title: "New Orders", value: "5", icon: "cart.fill", color: .blue)
                DashboardCard(title: "Stock Issues", value: "10", icon: "exclamationmark.triangle.fill", color: .red)
            }
            HStack(spacing: 10) {
                DashboardCard(title: "Orders in Transit", value: "8", icon: "truck.box.fill", color: .orange)
                DashboardCard(title: "Delivered Today", value: "12", icon: "checkmark.seal.fill", color: .green)
            }
        }
    }
    

    private var quickActionsSection: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Quick Actions")
                .font(.headline)
                .padding(.horizontal)
            
            HStack {
                NavigationLink(destination: OrdersView()) {
                    QuickActionButton(icon: "list.bullet.rectangle", text: "View Orders", color: .blue)
                }
                
                NavigationLink(destination: AddProductView()) {
                    QuickActionButton(icon: "plus.circle.fill", text: "Add Product", color: .green)
                }
            }
        }
    }
}


struct DashboardCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding(10)
                .background(Circle().fill(color))
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(width: 150, height: 100)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(5)
    }
}


struct QuickActionButton: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(color)
                .clipShape(Circle())
            
            Text(text)
                .font(.caption)
                .foregroundColor(.black)
        }
        .frame(width: 100, height: 100)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(username: "User")
    }
}


