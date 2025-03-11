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
    let backgroundColor = Color(red: 227/255, green: 253/255, blue: 249/255)
    var body: some View {
        VStack(spacing: 0) {
            
            

            ZStack {
                backgroundColor.edgesIgnoringSafeArea(.all)
                
                Image("PharmaFlow")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
                    .clipped()
                    .offset(y: 40)
            }

            Spacer()

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
                        username = inputUsername
                        isLoggedIn = true
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
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.horizontal, 20)

            Spacer(minLength: 50)
        }
        .edgesIgnoringSafeArea(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        .navigationBarHidden(true)
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false), username: .constant(""))
}
