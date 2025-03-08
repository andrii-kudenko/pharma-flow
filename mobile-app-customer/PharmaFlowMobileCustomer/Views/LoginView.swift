//
//  LoginView.swift
//  PharmaFlowMobileCustomer
//
//  Created by Dan on 2025-03-06.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    
    private let correctUsername = "admin"
    private let correctPassword = "password"

    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 30)
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    if username == correctUsername && password == correctPassword {
                        isAuthenticated = true
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                if username != correctUsername || password != correctPassword, !username.isEmpty {
                    Text("Invalid Credentials")
                        .foregroundColor(.red)
                }

                NavigationLink(destination: MainView(), isActive: $isAuthenticated) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}
