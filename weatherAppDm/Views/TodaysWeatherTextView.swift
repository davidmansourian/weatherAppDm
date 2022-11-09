//
//  TodaysWeatherTextView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI
import CoreLocation

struct TodaysWeatherTextView: View {
    @StateObject private var weatherModel = APILoader()
    @StateObject var locationManager = LocationManager.shared
    
    
    var body: some View {
        let temperature: Int = Int(Float(weatherModel.currentWeather?.temperature ?? 0))
        let maxTemp: Int = Int(Float(weatherModel.dailyWeather?.temperature_2m_max.first ?? 0))
        let minTemp: Int = Int(Float(weatherModel.dailyWeather?.temperature_2m_min.first ?? 0))
        let weatherCode: Int = weatherModel.currentWeather?.weathercode ?? 0
        let weatherDescription: String = TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherDescription ?? ""
        VStack{
            Text(weatherModel.cityName) // data ska senare hämtas från viewModel
                .font(Font.title)
                .bold()
                .foregroundColor(Color.white)
            Text("\(temperature)°") // data ska senare hämtas från viewModel
                .font(.system(size: 70))
                .foregroundColor(Color.white)
            Text(weatherDescription) // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
            Text("H:\(maxTemp)°" + " " + "L:\(minTemp)°") // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
        }
        .onAppear(){
            weatherModel.getWeather()

        }
    }
}
struct TodaysWeatherTextView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysWeatherTextView()
    }
}
