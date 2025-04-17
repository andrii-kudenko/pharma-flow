//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct ItemCatalogView: View {
    @StateObject private var viewModel = ItemCatalogViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading items...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.items) { item in
                        VStack(alignment: .leading) {
                            Text(item.codeName)
                                .font(.headline)
                            if let price = item.priceUsd {
                                Text("$\(price)")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .refreshable {
                        viewModel.fetchItems()
                    }
                }
            }
            .navigationTitle("Product Catalog")
        }
        .onAppear {
            viewModel.fetchItems()
        }
    }
}

#Preview {
    ItemCatalogView()
}
