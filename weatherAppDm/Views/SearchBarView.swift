//
//  SearchBarView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import SwiftUI
import CoreLocation
import MapKit

struct SearchBarView: View {
    @StateObject private var mapSearch = MapSearch()
    
    var body: some View {
        VStack{
            HStack{
                TextField("Search locations...", text: $mapSearch.searchTerm)
                    .foregroundColor(Color.white)
            }
            .font(.headline)
            .padding()
            .background(
                Rectangle()
                    .fill(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .cornerRadius(20)
                    .shadow(radius: 8)
                    .opacity(0.2))
//            VStack{
//                ForEach(mapSearch.locationResults, id: \.self) { location in
//                    Text(location.title)
//                        .foregroundColor(Color.white)
//                        .bold()
//                    Text(location.subtitle)
//                        .foregroundColor(Color.gray)
//                    Divider()
//                }
//            }
        }
    }
}
