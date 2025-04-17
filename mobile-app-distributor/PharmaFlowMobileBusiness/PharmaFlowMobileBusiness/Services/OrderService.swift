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

//    func submitOrder(request: CreateOrderRequest) async throws -> OrderConfirmation {
//        guard let url = URL(string: "\(Constants.baseURL)/orders/") else {
//            throw URLError(.badURL)
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // Convert to snake_case for the API
//        let encoder = JSONEncoder()
//        encoder.keyEncodingStrategy = .convertToSnakeCase
//        
//        let jsonData = try encoder.encode(request)
//        urlRequest.httpBody = jsonData
//
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//        // Check for HTTP errors
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw OrderError.serverError("Invalid HTTP response")
//        }
//        
//        if !(200..<300).contains(httpResponse.statusCode) {
//            let errorMsg = String(data: data, encoding: .utf8) ?? "Unknown error"
//            
//            if errorMsg.lowercased().contains("stock") {
//                throw OrderError.insufficientStock(errorMsg)
//            }
//            
//            throw OrderError.serverError("\(httpResponse.statusCode): \(errorMsg)")
//        }
//
//        // Convert from snake_case in the response
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        decoder.dateDecodingStrategy = .iso8601
//        
//        do {
//            return try decoder.decode(OrderConfirmation.self, from: data)
//        } catch {
//            print("Decoding error: \(error)")
//            print("Raw response: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
//            throw OrderError.serverError("Failed to decode response: \(error.localizedDescription)")
//        }
//    }
//
    
    func fetchAllOrders() async throws -> [OrderSummary] {
        guard let url = URL(string: "\(Constants.baseURL)/orders/all") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        print(String(data: data, encoding: .utf8) ?? "Invalid data")
        return try JSONDecoder().decode([OrderSummary].self, from: data)
    }

    func fetchOrderDetails(id: UUID) async throws -> OrderDetails {
        guard let url = URL(string: "\(Constants.baseURL)/orders/details/\(id)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        print(String(data: data, encoding: .utf8) ?? "Invalid data")
        return try JSONDecoder().decode(OrderDetails.self, from: data)
    }
    
    func fetchOrderStatusSummary() async throws -> OrderStatusSummary {
        guard let url = URL(string: "\(Constants.baseURL)/orders/status-summary") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(OrderStatusSummary.self, from: data)
    }
}
