//
//  AddProductView.swift
//  ProjectInceptionTemp
//
//  Created by Nicholas Sullivan on 2025-03-09.
//

import SwiftUI
import PostgresClientKit

struct AddProductView: View {
    let barcode: String // Raw barcode string passed to the view

    @State private var productName: String = ""
    @State private var manufacture: String = ""
    @State private var gtin: String = ""
    @State private var lot: String = ""
    @State private var expdate: String = ""
    @State private var refnum: String = ""
    @State private var prodate: String = ""
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
                
                Section(header: Text("Manufacture").foregroundColor(.black)) {
                    TextField("Manufacture", text: $manufacture)
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
                    TextField("GTIN", text: $gtin)
                        .foregroundColor(.black)
                }

                Section(header: Text("LOT").foregroundColor(.black)) {
                    TextField("LOT", text: $lot)
                        .foregroundColor(.black)
                }

                Section(header: Text("Expiry Date").foregroundColor(.black)) {
                    TextField("Date", text: $expdate)
                        .foregroundColor(.black)
                }

                Section(header: Text("Reference Number").foregroundColor(.black)) {
                    TextField("Reference Number", text: $refnum)
                        .foregroundColor(.black)
                }

                Section(header: Text("Production Date").foregroundColor(.black)) {
                    TextField("Production Date", text: $prodate)
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
                addProductToDatabase(
                    productName: productName,
                    gtin: gtin,
                    lot: lot,
                    expdate: expdate,
                    refnum: refnum,
                    prodate: prodate,
                    description: productDescription,
                    manufacture: manufacture,
                    certificate: certificate,
                    quantity: quantity
                ) { success in
                    if success {
                        alertTitle = "Success"
                        alertMessage = "Product added successfully to the database."
                    } else {
                        alertTitle = "Error"
                        alertMessage = "Failed to add product to the database."
                    }
                    showAlert = true
                }
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
        .onAppear {
            parseBarcode(barcode)
        }
    }

    func addProductToDatabase(productName: String, gtin: String, lot: String, expdate: String, refnum: String, prodate: String, description: String, manufacture: String, certificate: String, quantity: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                // Generate a unique UUID for the product
                let productId = UUID().uuidString

                // Format dates
                let formattedExpDate = formatDateString(expdate)
                let formattedProDate = formatDateString(prodate)

                // Configure the connection
                var configuration = PostgresClientKit.ConnectionConfiguration()
                configuration.host = "dpg-cvm53mpr0fns7380krq0-a.oregon-postgres.render.com"
                configuration.database = "pharmaflow"
                configuration.user = "pharmaflow_user"
                configuration.credential = .md5Password(password: "pPTucvAdn67V6zUrWoE5EoKzxjLrgRuT")

                let connection = try PostgresClientKit.Connection(configuration: configuration)
                defer { connection.close() }

                // Prepare the SQL statement
                let text = """
                    INSERT INTO products (id, product_name, gtin, lot_number, exp_date, ref_number, prod_date, description, manufacturer, certificate, quantity)
                    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
                """
                let statement = try connection.prepareStatement(text: text)
                defer { statement.close() }

                // Execute the query with parameter values
                try statement.execute(parameterValues: [
                    productId,              // id
                    productName,            // product_name
                    gtin,                   // gtin
                    lot,                    // lot_number
                    formattedExpDate,       // exp_date
                    refnum,                 // ref_number
                    formattedProDate,       // prod_date
                    description,            // description
                    manufacture,            // manufacturer
                    certificate,            // certificate
                    quantity                // quantity
                ])

                DispatchQueue.main.async {
                    completion(true) // Success
                }
            } catch {
                print("Database insertion error: \(error)")
                DispatchQueue.main.async {
                    completion(false) // Failure
                }
            }
        }
    }

    private func formatDateString(_ dateString: String) -> String {
        guard dateString.count == 6 else { return "1970-01-01 00:00:00" } // Default invalid date
        let year = "20" + dateString.prefix(2) // "24" -> "2024"
        let month = dateString.dropFirst(2).prefix(2) // "05"
        let day = dateString.dropFirst(4) // "31"
        return "\(year)-\(month)-\(day) 00:00:00" // "YYYY-MM-DD HH:MM:SS"
    }
    
    private func parseBarcode(_ barcode: String) {
        // Ensure barcode has correct length
        guard barcode.count == 58 else {
            print("Invalid barcode length: \(barcode.count) characters")
            return
        }

        // Extract values based on known positions
        gtin = "\(String(barcode[barcode.index(barcode.startIndex, offsetBy: 2)..<barcode.index(barcode.startIndex, offsetBy: 16)]))"
        lot = "\(String(barcode[barcode.index(barcode.startIndex, offsetBy: 18)..<barcode.index(barcode.startIndex, offsetBy: 26)]))"
        expdate = "\(String(barcode[barcode.index(barcode.startIndex, offsetBy: 29)..<barcode.index(barcode.startIndex, offsetBy: 35)]))"
        refnum = "\(String(barcode[barcode.index(barcode.startIndex, offsetBy: 38)..<barcode.index(barcode.startIndex, offsetBy: 49)]))"
        prodate = "\(String(barcode[barcode.index(barcode.startIndex, offsetBy: 52)..<barcode.index(barcode.startIndex, offsetBy: 58)]))"

        
        
        // Debugging output to verify parsed values
        print("GTIN: \(gtin)")
        print("LOT: \(lot)")
        print("Exp. Date: \(expdate)")
        print("Reference Number: \(refnum)")
        print("Production Date: \(prodate)")
    }
}








