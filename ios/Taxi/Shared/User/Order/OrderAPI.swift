//
//  OrderAPI.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 10.11.21.
//

import Foundation
public class OrderAPI{
    
    private var accessToken:String = ProfileManager.getAccessToken()
    private var baseUrl:String = "http://localhost:8080/private/order/"
    private let jsonDecoder:JSONDecoder = JSONDecoder()
    
    public func createOrder(destination:String){
        ProfileManager.getProfile(accessToken: self.accessToken) { (userInfo) in
            let url = URL(string: self.baseUrl+"createOrder/\(userInfo.email!)")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            let postString = "time=\(Calendar.current)&destination=\(destination))"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            request.addValue("bearer \(self.accessToken)", forHTTPHeaderField: "authorization")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    
                    // Check for Error
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
             
                    // Convert HTTP Response Data to a String
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("Response data string:\n \(dataString)")
                    }
            }
            task.resume()
        }
    }
    
    public func getOrders(completion: @escaping ((Array<Order>) -> Void)) {
        ProfileManager.getProfile(accessToken: self.accessToken) { (userInfo) in
            var retrievedOrders:Array<Order> = Array<Order>()
            
            let url = URL(string: self.baseUrl+"getOrders/\(userInfo.email!)")
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.addValue("bearer \(self.accessToken)", forHTTPHeaderField: "authorization")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    
                    // Check for Error
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
             
                    // Convert HTTP Response Data to a String
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        do{
                            retrievedOrders = try self.jsonDecoder.decode([Order].self, from: data)
                            print("Response data string:\n \(dataString)")
                            completion(retrievedOrders)
                        }
                        catch{
                            print("Error took place \(error)")
                            return
                        }
                    }
            }
            task.resume()
        }
    }
}
