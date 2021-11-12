//
//  CreateOrderView.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 11.11.21.
//

import SwiftUI
import MapKit

struct CreateOrderView: View {
    
    init(readableAddress:String) {
        self.selectedDestination = readableAddress
    }
    
    @State private var selectedDestination:String

    var body: some View {
        NavigationView{
            VStack{
                TextField("Address",text: $selectedDestination)
            }
            .navigationTitle("New ride order")
        }
    }
}
