//
//  ProductsView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-10.
//

import SwiftUI

struct ProductsView: View {
    @State private var searchText = ""
    @State private var selectedFilter: String = "All"

    let username: String = "User"
    
    let filters = ["All", "Low Stock", "High Stock"]
    
    let products: [Product] = [
        Product(name: "Aspirin", description: "Pain reliever", certificate: "Certified", quantity: 50),
        Product(name: "Ibuprofen", description: "Anti-inflammatory", certificate: "Certified", quantity: 15),
        Product(name: "Paracetamol", description: "Fever reducer", certificate: "Certified", quantity: 200)
    ]
    
    var filteredProducts: [Product] {
        products.filter { product in
            (searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())) &&
            (selectedFilter == "All" || (selectedFilter == "Low Stock" && product.quantity < 50) || (selectedFilter == "High Stock" && product.quantity >= 50))
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search product...", text: $searchText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Filter Dropdown
                Picker("Filter by quantity", selection: $selectedFilter) {
                    ForEach(filters, id: \.self) { filter in
                        Text(filter)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal)
                
                // Product List
                List(filteredProducts) { product in
                    ProductCard(product: product)
                }
                
                // Add Product Button
                NavigationLink(destination: ScanProductView(username: username, isNavigatedToHome: .constant(true))) {
                    Text("Add Product")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .navigationTitle("Products")
        }
    }
}


struct ProductCard: View {
    let product: Product

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.name).font(.headline)
                Text("Certificate: \(product.certificate)").font(.caption).foregroundColor(.gray)
            }
            Spacer()
            Text("\(product.quantity) units")
                .font(.caption)
                .padding(6)
                .background(product.quantity < 50 ? Color.red.opacity(0.2) : Color.green.opacity(0.2))
                .cornerRadius(8)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
