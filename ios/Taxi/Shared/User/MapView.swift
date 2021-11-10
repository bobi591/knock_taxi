//
//  MapView.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 10.11.21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    private var knockLocation:KnockLocation = KnockLocation();
    @State private var coordinateRegion:MKCoordinateRegion = MKCoordinateRegion();
    @State private var userTrackingMode:MapUserTrackingMode = .follow;
    @State private var destinationSearch:String = "";
    
    var body: some View {
        NavigationView{
            Map(coordinateRegion: $coordinateRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode)
                .onAppear(perform: updateUserLocation)
                .navigationTitle("Look for a ride...")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $destinationSearch)
        }
    }
    
    private func updateUserLocation(){
        knockLocation.updateLocation()
        self.coordinateRegion = knockLocation.coordinateRegion;
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
