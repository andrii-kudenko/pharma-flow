//
//  ItemCatalogViewModel.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-04-16.
//

import Foundation

@MainActor
class ItemCatalogViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchItems() {
        isLoading = true
        errorMessage = nil

        ItemService.shared.fetchItems { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                self.isLoading = false
                switch result {
                case .success(let fetchedItems):
                    self.items = fetchedItems
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
