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
import Combine

class SearchResultViewModel : ObservableObject {
    private var locationToken: Cancellable?
    private let mapSearch: MapSearch
    @Published var coordinate : CLLocationCoordinate2D?
    
    init(mapSearch: MapSearch) {
        self.mapSearch = mapSearch
    }
    
    
    func getLocation(location: MKLocalSearchCompletion) async -> CLLocationCoordinate2D {
        let searchRequest = MKLocalSearch.Request(completion: location)
        let search = MKLocalSearch(request: searchRequest)
            do{
                let response = try? await search.start()
                guard response != nil else{
                    return CLLocationCoordinate2D()
                }
                let coordinate = response?.mapItems.first?.placemark.coordinate
                self.coordinate = coordinate
                return coordinate ?? CLLocationCoordinate2D()
                
            }
        
        
//        search.start { response, error in
//            do{
//                if error == nil, let coordinate = response?.mapItems.first?.placemark.coordinate {
//                    self.coordinate = coordinate
//                }
//            }
//        }
    }
    
    
    enum MyErrors: Error {
        
    }
    
}
