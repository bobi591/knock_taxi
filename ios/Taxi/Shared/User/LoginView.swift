//
//  LoginView.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 9.11.21.
//

import SwiftUI
import Auth0

struct LoginView: View {
    
    @State private var apiAccessToken:String = "";
    
    var body: some View {
        VStack{
            Text("Welcome")
            Button("Login", action: {
                Auth0
                    .webAuth()
                    .scope("openid profile")
                    .audience("https://dev-1y7dhb8a.eu.auth0.com/userinfo")
                    .start { result in
                        switch result {
                        case .failure(let error):
                            // Handle the error
                            print("Error: \(error)")
                        case .success(let credentials):
                            apiAccessToken = credentials.accessToken!;
                            print("Credentials: \(credentials)")
                        }
                }
            }).buttonStyle(.borderedProminent)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
            
        }
    }
}
