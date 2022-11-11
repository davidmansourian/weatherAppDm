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
    @StateObject var subResultDaily = WeatherSubViewModelDaily()
    @StateObject var subResultCurrent = WeatherViewSubModelCurrent()
    @ObservedObject var searchResult = SearchResultViewModel.shared
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 650
    let minHeight: CGFloat = 600
    let maxHeight: CGFloat = 680
    var body: some View {
        ZStack(alignment: .bottom){
            if showResult{
                Color.black
                    .opacity(0.2)
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
//            let weatherCode: Int = subWeatherModel.subCurrentWeather?.weathercode ?? 0
//            let temperature: Int = Int(Float(subWeatherModel.subCurrentWeather?.temperature ?? 0))
//            let weatherIcon: String = TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherIcon ?? ""
//            let weatherDescription: String = TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherDescription ?? ""
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
                            Text("Test") // data ska senare hämtas från viewModel
                                .font(Font.title)
                                .foregroundColor(Color.white)
                            Image(systemName: TranslatedWeathercodes().weatherCodeProperties[subResultCurrent.weatherCode ?? 0]?.weatherIcon ?? "")
                                .font(.system(size: 60))
                                .foregroundColor(Color.white)
                            Text("\(subResultCurrent.temperature ?? 0)")
                                .font(Font.title)
                                .foregroundColor(Color.white)
                            Text(TranslatedWeathercodes().weatherCodeProperties[subResultCurrent.weatherCode ?? 0]?.weatherDescription ?? "")
                                .foregroundColor(Color.white)
                            DailyWeatherResultView()
                        }
                        .offset(y: -60)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .onAppear{
            print("chosen location in popup view: ", self.searchResult.chosenLocation)
            
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
                .foregroundColor(Color.black.opacity(0.8))
                .background(
                    LinearGradient(gradient: Gradient(colors: [.yellow, .blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .cornerRadius(25)
                    )
                .opacity(0.5)
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
