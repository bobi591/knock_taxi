//
//  LoginView.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 9.11.21.
//

import SwiftUI
import Auth0

struct LoginView: View {
    
    @State private var isLoggedIn:Bool = false;
    @State private var orders:Array<Order> = [];
    
    var body: some View {
        if isLoggedIn == true{
            //OrderView(orders: orders)
            MapView()
        }
        else{
            VStack{
                Text("Welcome")
                Button("Login", action: {
                    Auth0
                        .webAuth()
                        .scope("openid profile email")
                        .audience("http://localhost:8080/") //This URL is the current hostname of the Knock Taxi API
                        .start { result in
                            switch result {
                            case .failure(let error):
                                print("Error: \(error)")
                            case .success(let credentials):
                                ProfileManager.storeAccessToken(accessToken: credentials.accessToken!);
                                OrderAPI().getOrders { ordersArray in
                                    orders = ordersArray;
                                }
                                isLoggedIn = true;
                            }
                    }
                }).buttonStyle(.borderedProminent)
            }
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
