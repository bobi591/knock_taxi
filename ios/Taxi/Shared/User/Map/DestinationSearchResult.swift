//
//  DestinationSearchResult.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 11.11.21.
//

import Foundation
import MapKit

public class DestinationSearchResult : Identifiable{
    init(mapItem:MKMapItem, readableAddress:String) {
        self.mapItem = mapItem
        self.readableAddress = readableAddress
    }
    public let id = UUID()
    public let mapItem:MKMapItem
    public let readableAddress:String
}
