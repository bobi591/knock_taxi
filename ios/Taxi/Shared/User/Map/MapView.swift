//
//  MapView.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 10.11.21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    private var knockLocation:KnockLocation = KnockLocation()
    @State private var coordinateRegion:MKCoordinateRegion = MKCoordinateRegion()
    @State private var userTrackingMode:MapUserTrackingMode = .follow
    
    @State private var destinationSearchText:String = ""
    @State private var destinationSearchResults:[DestinationSearchResult] = []
    
    @State private var isDestinationSelected:Bool = false
    @State private var destinationReadableString:String = ""
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .center) {
                Map(coordinateRegion: $coordinateRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode).ignoresSafeArea(.keyboard)
                    .onAppear(perform: updateUserLocation)
                //If destination search results are in place, show a list of destinations on top of the map view
                if destinationSearchResults.count > 0{
                    List{
                        ForEach(destinationSearchResults) { destinationSearchResult in
                            Button(destinationSearchResult.readableAddress) {
                                self.destinationReadableString = destinationSearchResult.readableAddress
                                self.isDestinationSelected = true
                            }
                        }
                    }
                }
            }
            .navigationTitle("Look for a ride...")
                .navigationBarTitleDisplayMode(.inline)
        }
        //Definition of the destination search bar
        .searchable(text: $destinationSearchText, prompt: "Find destination").onChange(of: destinationSearchText) { newValue in
            onSearchableChange(newSearchFieldInput: newValue)
        }
        //Present a sheet when a destination is selected within the destination search
        .sheet(isPresented: $isDestinationSelected) {
            self.destinationReadableString = ""
            self.isDestinationSelected = false
        } content: {
            CreateOrderView(readableAddress: self.destinationReadableString)
        }

    }
    
    
    private func onSearchableChange(newSearchFieldInput:String){
        self.destinationSearchResults = []
        if newSearchFieldInput.count > 3 {
            localSearch(searchText: destinationSearchText) { parsedDestinationFoundResults in
                self.destinationSearchResults = parsedDestinationFoundResults
            }
        }
    }
    
    private func localSearch(searchText:String, completion: @escaping (([DestinationSearchResult]) -> Void)){
        let request:MKLocalSearch.Request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = MKCoordinateRegion(center: coordinateRegion.center, latitudinalMeters: 15000, longitudinalMeters: 15000)
        request.pointOfInterestFilter = .includingAll
        let localSearch:MKLocalSearch = MKLocalSearch(request: request)
        localSearch.start { searchResponse, error in
            if let searchResponse = searchResponse{
                var completionArray:[DestinationSearchResult] = []
                for mapItem in searchResponse.mapItems{
                    let destinationResult = convertMapItemToDestinationSearchResult(mapItem: mapItem)
                    if let destinationResult = destinationResult {
                        completionArray.append(destinationResult)
                    }
                }
                completion(completionArray)
            }
        }
    }
    
    private func convertMapItemToDestinationSearchResult(mapItem:MKMapItem) -> DestinationSearchResult?{
        let name = mapItem.placemark.name
        let thoroughfare = mapItem.placemark.thoroughfare
        let locality = mapItem.placemark.locality
        if let _ = name,
           let _ = thoroughfare,
           let _ = locality {
            return DestinationSearchResult(mapItem: mapItem, readableAddress: "\(name!), \(thoroughfare!), \(locality!)")
        }
        return nil
    }
    
    private func updateUserLocation(){
        knockLocation.updateLocation()
        self.coordinateRegion = knockLocation.coordinateRegion
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
