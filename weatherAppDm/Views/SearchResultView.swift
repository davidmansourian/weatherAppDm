//
//  SearchResultView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import SwiftUI

struct SearchResultView: View {
    @StateObject private var mapSearch = MapSearch()
    @StateObject var locationManager = LocationManager.shared
    @StateObject var searchResult = SearchResultViewModel()
    @State private var showResult = false
    @State private var offset: CGFloat = 200.0
    var body: some View {
        NavigationStack{
            ZStack{
                //                LinearGradient(gradient: Gradient(colors:[.yellow,.blue,.blue]), startPoint: .topTrailing, endPoint: .bottomLeading) // Change color depending on time of day and weather
                //                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        ForEach(mapSearch.locationResults, id: \.self) { location in
                            Button(action: {
                                print(searchResult.getLocation(location: location),
                                      showResult = true
                                      
                                )}
                                   , label: {
                                Text(location.title)
                                    .foregroundColor(Color.white)
                                    .bold()
                                Text(location.subtitle)
                                    .foregroundColor(Color.white)
                            })
                            Divider()
                                .foregroundColor(Color.white)
                        }
                    }
                    
                }
                WeatherResultView(showResult: $showResult)
                    .animation(.easeInOut(duration: 1), value: showResult)
                
                .toolbar{
                    ToolbarItemGroup(placement: .principal){
                        TextField("Search locations...", text: $mapSearch.searchTerm)
                            .foregroundColor(Color.white)
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
                    }
                }
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView()
    }
}
