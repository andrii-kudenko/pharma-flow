//
//  ClientsViewModel.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-04-17.
//

import Foundation

@MainActor
class ClientsViewModel: ObservableObject {
    @Published var clients: [ClientSummary] = []
    @Published var selectedClient: ClientDetails?

    @Published var isLoading = false
    @Published var isLoadingDetail = false
    @Published var errorMessage: String?


    func loadClients() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            clients = try await ClientService.shared.fetchAllClients()
        } catch {
            errorMessage = "Failed to load clients: \(error.localizedDescription)"
        }
    }

    func loadClientDetails(for id: UUID) async {
        isLoadingDetail = true
        errorMessage = nil
        defer { isLoadingDetail = false }

        do {
            selectedClient = try await ClientService.shared.fetchClientDetails(id: id)
        } catch {
            errorMessage = "Failed to load client details: \(error.localizedDescription)"
        }
    }

    func clearSelectedClient() {
        selectedClient = nil
    }
}
