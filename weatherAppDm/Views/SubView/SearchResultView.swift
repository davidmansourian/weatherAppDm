//
//  SearchResultView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//
//modal transition tutorial found here https://www.youtube.com/watch?v=I1fsl1wvsjY
import SwiftUI
import CoreLocation
import MapKit

struct SearchResultView: View {
    @StateObject var weatherModel = SubWeatherModdel()
    @State var chosenResult = CLLocationCoordinate2D()
    @State private var showResult = false
    @State private var offset: CGFloat = 200.0
    
    var body: some View {
        //     var theSearchTerm = weatherModel.mapSearch?.searchTerm
        NavigationStack{
            ZStack{
                //                LinearGradient(gradient: Gradient(colors:[.yellow,.blue,.blue]), startPoint: .topTrailing, endPoint: .bottomLeading) // Change color depending on time of day and weather
                //                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        ForEach(weatherModel.mapSearch.locationResults, id: \.self) { location in
                            Button(action:
                                    {
                                hideKeyboard()
                                Task{
                                    let result = await weatherModel.mapSearch.searchResultVM?.getLocation(location: location)
                                    self.chosenResult = result ?? CLLocationCoordinate2D()
                                    showResult = true
                                }
                            }
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
                
                //                print(searchResult.getLocation(location: location),
                //                          hideKeyboard(),
                //                          chosenResult = searchResult.getLocation(location: location),
                //                          self.searchResult.chosenLocation = chosenResult,
                //                          print("chosen result: ", chosenResult),
                //                          print("chosen location from class: ", self.searchResult.chosenLocation),
                //                          showResult = true
                //                    )
                .scrollDismissesKeyboard(.interactively)
                WeatherResultView(showResult: $showResult, chosenResult: $chosenResult)
                .animation(.easeInOut(duration: 0.3), value: showResult)
                
                .toolbar{
                    ToolbarItemGroup(placement: .principal){
                        TextField("Search locations...", text: $weatherModel.mapSearch.searchTerm)
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
                            .onTapGesture {
                                showResult = false
                            }
                        
                    }
                }
            }
            .onAppear(){
                // weatherModel.mapSearch.searchResultVM.getLocation(location: weatherModel.mapSearch.locationResults)
            }
        }
    }
}
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView()
    }
}
