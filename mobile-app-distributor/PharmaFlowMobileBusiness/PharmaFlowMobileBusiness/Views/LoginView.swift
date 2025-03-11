//
//  ContentView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-02.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var username: String

    @State private var inputUsername: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 0) { // Ensures elements are properly spaced
            // Logo / Image Section
            Image("PharmaFlow")
                .resizable()
                .scaledToFill() // Ensures it stretches properly
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.4) // Takes 40% of screen height
                .clipped()
                .opacity(0.3)
            
            Spacer() // Pushes login fields down

            // Login Form
            VStack(spacing: 16) {
                TextField("Username", text: $inputUsername)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                Button(action: {
                    if !inputUsername.isEmpty && !password.isEmpty {
                        username = inputUsername  // Store username
                        isLoggedIn = true  // Navigate to main app
                    }
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)

            Spacer(minLength: 50) // Adds space to push form to the bottom
        }
        .edgesIgnoringSafeArea(.top) // Ensures image doesn't get clipped
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures full height is used
        .background(Color.white) // Keeps a clean look
        .navigationBarHidden(true) // Hides navigation bar
    }
}



#Preview {
    LoginView(isLoggedIn: .constant(false), username: .constant(""))
}
