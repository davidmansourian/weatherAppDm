//
//  GeoCoderService.swift
//  weatherAppDm
//
//  Created by David on 2022-11-11.
//

import Foundation
import CoreLocation
import Combine

class GeoCodeService: ObservableObject{
    @Published var cityName: String?
    let geoCoder = CLGeocoder()
    
    
    func getCityName(theLocation: CLLocation?){
        guard theLocation != nil else{
            print("No location")
            return
        }
        geoCoder.reverseGeocodeLocation(theLocation ?? CLLocation(), completionHandler: { (placemarks, _) -> Void in
            for placemark in placemarks ?? []{
                if let city = placemark.locality{
                    self.cityName = city
                }
            }
        })
    }
}
