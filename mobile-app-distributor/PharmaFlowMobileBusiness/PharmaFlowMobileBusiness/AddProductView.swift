//
//  AddProductView.swift
//  ProjectInceptionTemp
//
//  Created by Nicholas Sullivan on 2025-03-09.
//

import SwiftUI

struct AddProductView: View {
    @State private var productName: String = "Product"
    @State private var productDescription: String = "This is the description of the product"
    @State private var certificate: String = "Product Certificate"
    @State private var quantity: String = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("New Product")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding(.leading, 16)
                .padding(.top, 16)
            
            Form {
                Section(header: Text("Name").foregroundColor(.black)) {
                    TextField("Product", text: $productName)
                        .foregroundColor(.black)
                }
                
                Section(header: Text("Description").foregroundColor(.black)) {
                    TextEditor(text: $productDescription)
                        .frame(height: 200)
                        .foregroundColor(.black)
                }
                
                Section(header: Text("Certificate").foregroundColor(.black)) {
                    TextField("Enter certificate", text: $certificate)
                        .foregroundColor(.black)
                }
                
                Section(header: Text("Quantity").foregroundColor(.black)) {
                    TextField("Enter quantity", text: $quantity)
                        .foregroundColor(.black)
                        .keyboardType(.numberPad)
                }
            }.scrollContentBackground(.hidden)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
            
            Spacer()
            
            Button(action: {
                if productName.isEmpty || productDescription.isEmpty || certificate.isEmpty || quantity.isEmpty {
                    alertTitle = "Update Failed"
                    alertMessage = "An error occurred when updating the inventory of \(productName). Please ensure all fields are filled out correctly."
                } else {
                    alertTitle = "Update Successful!"
                    alertMessage = "The inventory for \(productName) has been successfully updated."
                }
                showAlert = true
            }) {
                Text("Update Inventory")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(16)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .background(Color.white)
        .navigationTitle("New Product")
        
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}




