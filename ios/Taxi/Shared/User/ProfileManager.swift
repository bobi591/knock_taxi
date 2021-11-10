//
//  CredentialsManager.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 10.11.21.
//

import Foundation
import Auth0

class ProfileManager {
    
    static private var accessToken:String? = nil;
    static public var customerId:String? = nil;
    
    public static func storeAccessToken(accessToken: String){
        ProfileManager.accessToken = accessToken;
    }
    
    public static func getProfile(accessToken: String, completion: @escaping((UserInfo)->Void)){
        Auth0
            .authentication()
            .userInfo(withAccessToken: accessToken)
            .start { result in
                switch(result) {
                case .success(let profile):
                    completion(profile);
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                }
            }
    }
    
    public static func getAccessToken() -> String{
        return ProfileManager.accessToken!;
    }
}
