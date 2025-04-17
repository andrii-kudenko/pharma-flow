//
//  AddProductView.swift
//  ProjectInceptionTemp
//
//  Created by Nicholas Sullivan on 2025-03-09.
//

import SwiftUI

struct AddProductView: View {
    @State private var productName: String = ""
    
    @State private var gtin: String = "(01)04015630920129"
    @State private var lot: String = "(10)66248702"
    @State private var expdate: String = "(17)240531"
    @State private var refnum: String = "(240)03184897190"
    @State private var prodate: String = "(11)230511"
    
    @State private var productDescription: String = "Description"
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
                
                Section(header: Text("Certificate").foregroundColor(.black)) {
                    TextField("Enter certificate", text: $certificate)
                        .foregroundColor(.black)
                }
                
                Section(header: Text("Quantity").foregroundColor(.black)) {
                    TextField("Enter quantity", text: $quantity)
                        .foregroundColor(.black)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("GTIN").foregroundColor(.black)) {
                    TextField("0", text: $gtin)
                        .foregroundColor(.black)
                }
                
                Section(header: Text("LOT").foregroundColor(.black)) {
                    TextField("0", text: $lot)
                        .foregroundColor(.black)
                }
                
                Section(header: Text("Expiry Date").foregroundColor(.black)) {
                    TextField("Date", text: $expdate)
                        .foregroundColor(.black)
                }
                
                Section(header: Text("Refrence Number").foregroundColor(.black)) {
                    TextField("0", text: $refnum)
                        .foregroundColor(.black)
                }
                
                Section(header: Text("Production Date").foregroundColor(.black)) {
                    TextField("Date", text: $prodate)
                        .foregroundColor(.black)
                }
                
                Section(header: Text("Description (Optional)").foregroundColor(.black)) {
                    TextEditor(text: $productDescription)
                        .frame(height: 200)
                        .foregroundColor(.black)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(20)

            Spacer()

            Button(action: {
                if productName.isEmpty || certificate.isEmpty || quantity.isEmpty {
                    alertTitle = "Update Failed"
                    alertMessage = "An error occurred when updating the inventory of \(productName). Please ensure all fields are filled out correctly."
                } else {
                    alertTitle = "Update Successful!"
                    alertMessage = "The inventory for \(productName) has been successfully updated."
                }
                showAlert = true
            }) {
                Text("Add Product")
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
        .navigationBarBackButtonHidden(false)
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}






