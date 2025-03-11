//
//  ContentView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Dan on 2025-03-02.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var username: String = "Bill Bob"
    @State private var password: String = "Password"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("PharmaFlow")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.65)
                    .opacity(0.3)
                    .clipped()
                
                VStack(spacing: 16) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    NavigationLink(destination: HomeView(username: username)) {
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
                .frame(height: UIScreen.main.bounds.height * 0.3)
                .background(Color.green.opacity(0.1))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


#Preview {
    ContentView()
}
