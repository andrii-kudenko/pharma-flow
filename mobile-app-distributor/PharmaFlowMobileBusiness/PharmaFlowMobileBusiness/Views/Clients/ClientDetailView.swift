//
//  ClientDetailView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-04-17.
//


import SwiftUI

struct ClientDetailView: View {
    let clientId: UUID
    @EnvironmentObject var viewModel: ClientsViewModel

    var body: some View {
        VStack{
            if viewModel.isLoadingDetail {
                ProgressView("Loading Client...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text(error).foregroundColor(.red)
                    Button("Retry") {
                        Task { await viewModel.loadClientDetails(for: clientId) }
                    }
                }
                .padding()
            } else if let client = viewModel.selectedClient {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Full name from first and last name
                        Text("\(client.f_name) \(client.l_name)")
                            .font(.title2)
                            .bold()
                        
                        // Company name
                        
                        Text(client.company_name ?? "")
                            .font(.title3)
                            .foregroundColor(.secondary)
                        
                        Divider()
                        
                        Group {
                            Text("Contact Information")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            HStack {
                                Text("Email:").bold()
                                Text(client.email)
                                    .textSelection(.enabled)
                            }
                            
                            if let phone = client.phone {
                                HStack {
                                    Text("Phone:").bold()
                                    Text(phone)
                                }
                            }
                        }
                        
                        Divider()
                        
                        Group{
                            Text("Addresses")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            if let delivery = client.delivery_address {
                                Text("Delivery Address:").bold()
                                Text(delivery)
                                    .padding(.bottom, 8)
                            } else {
                                Text("No delivery address provided")
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 8)
                            }
                            
                            if let billing = client.billing_address {
                                Text("Billing Address:").bold()
                                Text(billing)
                            } else {
                                Text("No billing address provided")
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Order Information")
                                .font(.headline)
                            
                            HStack {
                                Text("Total Orders:")
                                Spacer()
                                Text("\(client.orders_count ?? 0)")
                                    .bold()
                            }
                        }
                    }
                    .padding()
                }
            } else {
                Text("Client not found.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task{
            if viewModel.selectedClient?.id != clientId {
                await viewModel.loadClientDetails(for: clientId)
            }
        }
        .refreshable {
            if viewModel.selectedClient?.id != clientId {
                await viewModel.loadClientDetails(for: clientId)
            }
        }
            
    }
    
}
