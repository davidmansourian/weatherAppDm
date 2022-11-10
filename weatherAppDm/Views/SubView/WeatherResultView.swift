//
//  WeatherResultView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-10.
//

import SwiftUI
import CoreLocation

// shared class solution found here https://stackoverflow.com/questions/68675389/modify-published-variable-from-another-class-that-is-not-declared-in-swiftui
//modal transition tutorial found here https://www.youtube.com/watch?v=I1fsl1wvsjY

struct WeatherResultView: View {
    @Binding var showResult: Bool
    @StateObject var subWeatherModel = SubWeatherService()
    @ObservedObject var searchResult = SearchResultViewModel.shared
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 650
    let minHeight: CGFloat = 600
    let maxHeight: CGFloat = 680
    var body: some View {
        ZStack(alignment: .bottom){
            if showResult{
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture{
                        showResult = false
                    }
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.linear(duration: 1), value: isDragging)
    }
    
    var mainView: some View{
        VStack{
            let weatherCode: Int = subWeatherModel.subCurrentWeather?.weathercode ?? 0
            let temperature: Int = Int(Float(subWeatherModel.subCurrentWeather?.temperature ?? 0))
            let weatherIcon: String = TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherIcon ?? ""
            let weatherDescription: String = TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherDescription ?? ""
            ZStack{
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            
            ZStack{
                VStack{
                    if showResult{
                        LikeButtonView()
                            .offset(x: -160, y: -90)
                            .padding()
                        VStack{
                            Text(subWeatherModel.subCityName ?? "-") // data ska senare hämtas från viewModel
                                .font(Font.title)
                                .foregroundColor(Color.white)
                            Image(systemName: weatherIcon)
                                .font(.system(size: 60))
                                .foregroundColor(Color.white)
                            Text("\(temperature)")
                                .font(Font.title)
                                .foregroundColor(Color.white)
                            Text(weatherDescription)
                                .foregroundColor(Color.white)
                            ScrollView(.horizontal, showsIndicators: false) {
                                Grid{
                                    GridRow{
                                        ForEach(0...6, id: \.self){ i in
                                            Text("Today")
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .padding()
                                    GridRow{
                                        ForEach(0...6, id: \.self){ i in
                                            Image(systemName: "cloud.fill")
                                                .renderingMode(.original)
                                        }
                                    }
                                    .padding()
                                    GridRow{
                                        ForEach(0...6, id: \.self){ i in
                                            Text("10")
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .padding()
                                }
                            }
                            .background(
                                Rectangle()
                                    .fill(Color.white.opacity(0.2))
                            )
                            //.background(Color.gray.opacity(0))
                            .cornerRadius(15)
                            .padding()
                            .shadow(radius: 3)
                        }
                        .offset(y: -60)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .onAppear{
            print("onappear mannen")
            print("chosen location in popup view: ", self.searchResult.chosenLocation)
            subWeatherModel.getWeather(latitude: self.searchResult.chosenLocation.latitude, longitude: self.searchResult.chosenLocation.longitude)
            subWeatherModel.getCityName(latitude: self.searchResult.chosenLocation.latitude, longitude: self.searchResult.chosenLocation.longitude)
            
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack{
                RoundedRectangle(cornerRadius: 25.0)
                Rectangle()
                    .frame(height: curHeight)
                    .cornerRadius(25)
            }
                .onTapGesture {
                    showResult = false
                }
                .foregroundColor(Color.black.opacity(1))
                .background(
                    LinearGradient(gradient: Gradient(colors: [.yellow, .blue]), startPoint: .top, endPoint: .bottom)
                        .cornerRadius(25)
                    )
                .opacity(0.5)
            
            //                LinearGradient(gradient: Gradient(colors:[.yellow,.blue,.blue]), startPoint: .topTrailing, endPoint: .bottomLeading) // Change color depending on time of day and weather
            //                    .edgesIgnoringSafeArea(.all)
        )
        .animation(isDragging ? nil : .easeInOut(duration: 0.45), value: isDragging)
    }
    
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging{
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount / 6
                }
                else{
                    curHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded{ val in
                prevDragTranslation = .zero
                isDragging = false
                if curHeight > maxHeight{
                    curHeight = maxHeight
                }
                else if curHeight < maxHeight{
                    curHeight = minHeight
                }
//                else if curHeight <= minHeight{
//                    showResult = false
//                }
                
            }
    }
}

struct WeatherResultView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherResultView(showResult: .constant(true))
    }
}
