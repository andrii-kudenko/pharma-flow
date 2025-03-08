//
//  MainView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct ProductCatalogView: View {
    let products = [
        Product(name: "Gloves", availability: "In Stock", price: "$10", description: "Disposable medical gloves."),
        Product(name: "Mask", availability: "Out of Stock", price: "$5", description: "Surgical protective mask."),
        Product(name: "Thermometer", availability: "In Stock", price: "$25", description: "Digital thermometer.")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Product Catalog")
                    .font(.largeTitle)
                    .padding()
                
                List(products) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                Text(product.availability)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(product.price)
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
}
