//
//  ClientService.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-04-17.
//

import Foundation

class ClientService {
    static let shared = ClientService()
    private init() {}

    func fetchAllClients() async throws -> [ClientSummary] {
        guard let url = URL(string: "\(Constants.baseURL)/clients/all") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Print JSON for debugging
        if let json = String(data: data, encoding: .utf8) {
            print("Client list JSON: \(json)")
        }
        
        // Simple direct decoding
        let decoder = JSONDecoder()
        return try decoder.decode([ClientSummary].self, from: data)
    }

    func fetchClientDetails(id: UUID) async throws -> ClientDetails {
        guard let url = URL(string: "\(Constants.baseURL)/clients/\(id)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Print JSON for debugging
        if let json = String(data: data, encoding: .utf8) {
            print("Client details JSON: \(json)")
        }
        
        // Simple direct decoding
        let decoder = JSONDecoder()
        return try decoder.decode(ClientDetails.self, from: data)
    }
}
