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
        VStack {
            if viewModel.isLoadingDetail {
                ProgressView("Loading Client...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        Task { await viewModel.loadClientDetails(for: clientId) }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            } else if let client = viewModel.selectedClient {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        //Header Section
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(client.f_name) \(client.l_name)")
                                .font(.title)
                                .bold()
                            if let company = client.company_name {
                                Text(company)
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)).shadow(radius: 1))

                        //Contact Info
                        SectionCard(title: "Contact Information") {
                            VStack(alignment: .leading, spacing: 8) {
                                InfoRow(label: "Email", value: client.email)
                                
                                if let phone = client.phone {
                                    InfoRow(label: "Phone", value: phone)
                                }
                            }
                        }

                        //Address Info
                        SectionCard(title: "Addresses") {
                            Group{
                                if let delivery = client.delivery_address {
                                    InfoRow(label: "Delivery", value: delivery)
                                } else {
                                    Text("No delivery address provided")
                                        .foregroundColor(.secondary)
                                }
                                
                                if let billing = client.billing_address {
                                    InfoRow(label: "Billing", value: billing)
                                } else {
                                    Text("No billing address provided")
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                        }

                        //Order Info
                        SectionCard(title: "Order Information") {
                            HStack{
                                Text("Total Orders: \(client.orders_count ?? 0)")
                                Spacer()
                            }
                        }.frame(maxWidth: .infinity)
                    }
                    .padding()
                }
            } else {
                Text("Client not found.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task {
            if viewModel.selectedClient?.id != clientId {
                await viewModel.loadClientDetails(for: clientId)
            }
        }
        .refreshable {
            if viewModel.selectedClient?.id != clientId {
                await viewModel.loadClientDetails(for: clientId)
            }
        }
        .navigationTitle("Client Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Reusable Views

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(label):")
                .bold()
                .frame(width: 100, alignment: .leading)
            Text(value)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SectionCard<Content: View>: View {
    let title: String
    let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 4)

            content()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)).shadow(radius: 1))
    }
}
