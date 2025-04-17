//
//  ClientsView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-04-17.
//

import SwiftUI

struct ClientsView: View {
    @StateObject private var viewModel = ClientsViewModel()

    var body: some View {
        NavigationStack {
            VStack{
                if viewModel.isLoading {
                    ProgressView("Loading Clients...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text(error).foregroundColor(.red)
                        Button("Retry") {
                            Task { await viewModel.loadClients() }
                        }
                    }
                    .padding()
                } else if viewModel.clients.isEmpty {
                    Text("No clients found.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.clients.compactMap { $0.id != nil ? $0 : nil }) { client in
                        NavigationLink {
                            ClientDetailView(clientId: client.id!)
                                .environmentObject(viewModel)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(client.name).font(.headline)
                                Text(client.company_name ?? "Unspecified").font(.subheadline)
                                Text("Last Order: \(formatDateString(client.last_order_date))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }.navigationTitle("Clients")
            
        }
        .task {
            await viewModel.loadClients()
        }
        .refreshable {
            await viewModel.loadClients()
        }
    }
}



func formatDateString(_ date: String?) -> String {
    guard let date = date else { return "N/A" }
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"

    if let parsedDate = inputFormatter.date(from: date) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .medium
        return outputFormatter.string(from: parsedDate)
    } else {
        return date
    }
}

