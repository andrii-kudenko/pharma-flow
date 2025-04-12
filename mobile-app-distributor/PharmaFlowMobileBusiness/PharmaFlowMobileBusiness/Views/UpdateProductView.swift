import SwiftUI

struct UpdateProductView: View {
    @Binding var isNavigatedToHome: Bool
    @State private var productName: String = "Sample Product"
    @State private var currentQuantity: Int = 10
    @State private var enteredQuantity: String = ""
    @State private var showSuccessAlert: Bool = false
    @State private var showInvalidAlert: Bool = false
    @State private var certificate: String = "ABC123456"
    @State private var gtin: String = "0123456789012"
    @State private var lot: String = "LOT12345"
    @State private var expdate: String = "2025-12-31"
    @State private var refnum: String = "REF12345"
    @State private var prodate: String = "2023-01-01"
    @State private var productDescription: String = "This is a sample product description."
    let username: String

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text(productName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 80)

                Text("Current Quantity: \(currentQuantity)")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.9))
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.25)
            .padding(20)
            .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.green.opacity(0.6)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(12)
            .clipped()

            Form {
                Section(header: Text("Update Quantity").font(.headline)) {
                    TextField("Enter New Quantity", text: $enteredQuantity)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Product Details").font(.headline)) {
                    HStack {
                        Text("Name:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(productName)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Certificate:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(certificate)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("GTIN:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(gtin)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("LOT:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(lot)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Expiry Date:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(expdate)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Reference Number:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(refnum)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Production Date:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(prodate)
                            .foregroundColor(.gray)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description (Optional):")
                            .fontWeight(.semibold)
                        Text(productDescription)
                            .foregroundColor(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding(.horizontal, 10)

            Button(action: {
                if enteredQuantity.trimmingCharacters(in: .whitespaces).isEmpty {
                    showInvalidAlert.toggle()
                } else if let quantity = Int(enteredQuantity), quantity <= 0 {
                    showInvalidAlert.toggle()
                } else if Int(enteredQuantity) == nil {
                    showInvalidAlert.toggle()
                } else {
                    currentQuantity += Int(enteredQuantity) ?? 0
                    showSuccessAlert.toggle()
                }
            }) {
                Text("Update Product")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
            }
        }
        .navigationTitle("")
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showInvalidAlert) {
            Alert(
                title: Text("Invalid Entry"),
                message: Text("Please enter a valid quantity greater than 0."),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Product Updated"),
                message: Text("\(productName) updated to quantity: \(currentQuantity)"),
                dismissButton: .default(Text("OK")) {
                    isNavigatedToHome = false
                }
            )
        }
    }
}

struct UpdateProductView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProductView(isNavigatedToHome: .constant(true), username: "User")
    }
}
