//
//  KnockLocation.swift
//  Taxi (iOS)
//
//  Created by Boris Georgiev on 10.11.21.
//

import Foundation
import MapKit

class KnockLocation : NSObject, CLLocationManagerDelegate{
    public var locationManager:CLLocationManager = CLLocationManager()
    public var coordinateRegion:MKCoordinateRegion = MKCoordinateRegion()
    
    public func updateLocation(){
        locationManager.delegate = self
        if locationManager.authorizationStatus != .authorizedWhenInUse{
            locationManager.requestWhenInUseAuthorization()
        }
        else{
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            if locationManager.location != nil{
                let latitude = locationManager.location?.coordinate.latitude
                let longtitude = locationManager.location?.coordinate.longitude
                let center = CLLocationCoordinate2D(latitude: latitude!, longitude: longtitude!)
                self.coordinateRegion = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
            }
            else{
                updateLocation()
            }
        }
    }
}
