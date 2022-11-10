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
    @Published var chosenLocation: CLLocationCoordinate2D
    static let shared = SearchResultViewModel(chosenLocation: CLLocationCoordinate2D())
    
    init(chosenLocation: CLLocationCoordinate2D) {
        self.chosenLocation = chosenLocation
    }
    
    
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
