//
//  OrderService.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-16.
//

import Foundation

class OrderService {
    static let shared = OrderService()
    private init() {}

    func submitOrder(request: CreateOrderRequest) async throws -> OrderConfirmation {
        guard let url = URL(string: "\(Constants.baseURL)/orders/") else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(request)
        urlRequest.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            let errorMsg = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw OrderError.serverError(errorMsg)
        }

        let decoder = JSONDecoder()
        let confirmation = try decoder.decode(OrderConfirmation.self, from: data)
        return confirmation
    }
}
