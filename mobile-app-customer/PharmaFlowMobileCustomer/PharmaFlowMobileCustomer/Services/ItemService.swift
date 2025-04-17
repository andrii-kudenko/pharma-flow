//
//  ItemService.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-16.
//

import Foundation

class ItemService{
    static let shared = ItemService();
    
    private init() {}
    
    func fetchItems(completion: @escaping (Result<[Item], Error>) -> Void) {
        let urlString = "\(Constants.baseURL)/items"
        print (urlString)

        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let items = try decoder.decode([Item].self, from: data)
                completion(.success(items))
            } catch {
                print("❌ Decoding failed:", error)
                print("Raw JSON:", String(data: data, encoding: .utf8) ?? "N/A")
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
