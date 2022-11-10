//
//  SearchResultViewModel.swift
//  weatherAppDm
//
//  Created by David on 2022-11-10.
//

import Foundation


import Foundation
import CoreLocation
import MapKit

class SearchResultViewModel : ObservableObject {
    @Published private var coordinate : CLLocationCoordinate2D?
    
    func getLocation(location: MKLocalSearchCompletion) -> CLLocationCoordinate2D{
        let searchRequest = MKLocalSearch.Request(completion: location)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if error == nil, let coordinate = response?.mapItems.first?.placemark.coordinate {
                self.coordinate = coordinate
            }
        }
        return self.coordinate ?? CLLocationCoordinate2D()
    }
}
