//
//  MapSearch.swift
//  weatherAppDm
//
//  Created by David on 2022-11-09.
//

import Foundation

import SwiftUI
import Combine
import MapKit

// https://stackoverflow.com/questions/33380711/how-to-implement-auto-complete-for-address-using-apple-map-kit/67131376#67131376

class MapSearch: NSObject, ObservableObject{
    @Published var locationResults: [MKLocalSearchCompletion] = []
    @Published var searchTerm = ""
    private var cancellable: Cancellable?
    private var chosenLocationToken: Cancellable?
    @Published var theChosenLocation: CLLocationCoordinate2D?
    var searchResultVM: SearchResultViewModel?
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var currentPromise: ((Result<[MKLocalSearchCompletion], Error>) -> Void)?
    
    override init(){
        super.init()
        searchResultVM = SearchResultViewModel(mapSearch: self)
        searchCompleter.delegate = self
        searchCompleter.region = MKCoordinateRegion(.world)
        searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address])
        
        cancellable = $searchTerm
            .receive(on: DispatchQueue.main)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap ({currentSearchTerm in
                self.searchTermToResults(searchTerm: currentSearchTerm)
            })
            .sink(receiveCompletion: {(completion) in
                print("map success")
            }, receiveValue: {(results) in
                print("2:", results)
                if self.searchTerm.isEmpty{
                    print(self.searchCompleter.results.count)
                    print(self.locationResults)
                }
                else{
                    print("haha")
                    self.locationResults = results
                }
            })
        
        chosenLocationToken = searchResultVM?.$coordinate
            .sink(receiveCompletion: {completion in
                print("Det är completed jag e ")
            }, receiveValue: {[weak self] theLocation in
                if let theLocation{
                    print(theLocation)
                    self?.theChosenLocation = theLocation
                }
            })
    }
    
    func searchTermToResults(searchTerm: String) -> Future<[MKLocalSearchCompletion], Error> {
        Future { promise in
            self.searchCompleter.queryFragment = searchTerm
            self.currentPromise = promise
        }
    }
}

extension MapSearch : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        print("results:", completer.results)
        print(currentPromise)
        currentPromise?(.success(completer.results))
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error){
        print(error.localizedDescription)
    }
}


