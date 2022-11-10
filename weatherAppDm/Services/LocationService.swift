//
//  LocationService.swift
//  weatherAppDm
//
//  Created by David on 2022-11-07.
//

import Foundation
import CoreLocation

//
class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocation?
    public var hasUpdatedLocation: Bool = true
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        //hasUpdatedLocation = false
    }

    
     func updateLocation(){
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location
        locationManager.stopUpdatingLocation()
        hasUpdatedLocation = true

    }

}
