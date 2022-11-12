//
//  ScreenView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI



struct ScreenView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var weatherPages: FetchedResults<SavedWeather>
    @State private var showSearchBar = false
    @State private var isLiked = false
    @State private var selection: String? = nil
    @StateObject private var weatherModel = APILoader()
    @StateObject var locationManager = LocationManager.shared
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))

    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors:[.yellow,.blue,.blue]), startPoint: .topTrailing, endPoint: .bottomLeading) // Change color depending on time of day and weather
                //TranslatedWeathercodes().backGroundForWeatherCode[0]
                    .edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .center, spacing: 15) {
                        TodaysWeatherTextView()
                        TodaysWeatherView()
                        ForecastView()
                    }
                }
                .onTapGesture {
                    if showSearchBar{
                        withAnimation(.easeInOut(duration: 0.4)){
                            showSearchBar.toggle()
                        }
                        
                    }
                }
               .blur(radius: showSearchBar ? 10 : 0)
               .scrollDisabled(showSearchBar ? true : false)
               .padding(.top, 1)
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button {
                            withAnimation(.linear(duration: 0.2)){
                                showSearchBar.toggle()
                            }
                        } label: {
                            if !showSearchBar{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.black)
                                    .padding(10)
                                    .background(Color.white.opacity(0.4))
                                    .clipShape(Circle())
                            }
                        }
                    }
                    if !showSearchBar{
                        ToolbarItemGroup(placement: .navigationBarLeading){
                            if !showSearchBar{
                                NavigationLink(destination:SettingsView().transition(transition)){
                                    Image(systemName: "gearshape")
                                        .foregroundColor(Color.black)
                                        .padding(10)
                                        .background(Color.white.opacity(0.4))
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    if showSearchBar{
                        ToolbarItemGroup(placement: .navigationBarLeading){
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.4)){
                                    showSearchBar.toggle()
                                }
                            }){
                                Image(systemName: "arrow.left")
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                }
                if showSearchBar{
                    SearchResultView()
                    
                }
            }
            .onAppear(){
                locationManager.updateLocation()
            }
            .refreshable {
                locationManager.updateLocation()
            }
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
    }
}

