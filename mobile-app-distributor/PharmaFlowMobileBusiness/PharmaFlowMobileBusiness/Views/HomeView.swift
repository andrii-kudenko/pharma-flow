//
//  HomeView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Nicholas Sullivan on 2025-03-10.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isNavigatedToScan: Bool = false
    @StateObject private var viewModel = HomeViewModel()
    
    let username: String = "User"
    
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
                .refreshable {
                    await viewModel.loadSummary()
                }
            }
            .navigationBarHidden(true)
        }.task {
            await viewModel.loadSummary()
        }

    }
    

    private var dashboardSection: some View {
        Group {
            if let summary = viewModel.summary {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notifications")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 20)

                    HStack(spacing: 10) {
                        DashboardCard(title: "Pending", value: "\(summary.pending)", icon: "clock.badge.exclamationmark", color: .blue)
                        DashboardCard(title: "Confirmed", value: "\(summary.confirmed)", icon: "checkmark.circle", color: .green)
                    }

                    HStack(spacing: 10) {
                        DashboardCard(title: "Shipped", value: "\(summary.shipped)", icon: "truck.box.fill", color: .orange)
                        DashboardCard(title: "Completed", value: "\(summary.completed)", icon: "checkmark.seal.fill", color: .gray)
                    }
                }
            } else if viewModel.isLoading {
                ProgressView("Loading Summary...")
                    .frame(maxWidth: .infinity, alignment: .center)
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
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
                
                NavigationLink(
                                    destination: ScanProductView(username: username, isNavigatedToHome: $isNavigatedToScan),
                                    isActive: $isNavigatedToScan
                                ) {
                    QuickActionButton(icon: "camera.fill", text: "Scan Product", color: .yellow)
                }
                NavigationLink(destination: AddProductView(barcode: "")) {
                    QuickActionButton(icon: "plus.circle.fill", text: "Manual Add Product", color: .green)
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
        HomeView()
    }
}


