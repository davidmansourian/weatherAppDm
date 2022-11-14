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
    @ObservedObject var todays: WeatherViewModelCurrent
    @StateObject var locationManager = LocationManager.shared
    @StateObject var codeTranslator = TranslatedWeathercodes()
    @StateObject var geoCoder = GeoCodeService()
    
    
    var body: some View {
        //        let temperature: Int = Int(Float(weatherModel.currentWeather?.temperature ?? 0))
        //        let maxTemp: Int = Int(Float(weatherModel.dailyWeather?.temperature_2m_max.first ?? 0))
        //        let minTemp: Int = Int(Float(weatherModel.dailyWeather?.temperature_2m_min.first ?? 0))
        //        let weatherDescription: String = TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherDescription ?? ""
        VStack{
            Text(todays.cityName ?? "") // data ska senare hämtas från viewModel
                .font(Font.title)
                .bold()
                .foregroundColor(Color.white)
            Text("\(todays.temperature ?? 0)°") // data ska senare hämtas från viewModel
                .font(.system(size: 50))
                .foregroundColor(Color.white)
            Text(codeTranslator.weatherCodeProperties[todays.weatherCode ?? 0]?.weatherDescription ?? "") // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
            Text("H:\(Int(Float(todays.maxTemp?.first ?? 0)))°" + " " + "L:\(Int(Float(todays.minTemp?.first ?? 0)))°") // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
        }
        
    }
}
struct TodaysWeatherTextView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysWeatherTextView(todays: WeatherViewModelCurrent(weatherModel: MainWeatherAppModel()))
    }
}
