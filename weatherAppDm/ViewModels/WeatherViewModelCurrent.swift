//
//  WeatherViewModelCurrent.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import Foundation
import SwiftUI


class WeatherViewModelCurrent: ObservableObject{

    
    private var weatherModel = APILoader()
    @Published var temperature: Float = 0
    @Published var weathercode: Int = 0
    @Published var maxTemp: Float = 0
    @Published var minTemp: Float = 0
    
    init(weatherModel: APILoader){
        self.weatherModel = weatherModel
    }
    
    public func refresh(){
        self.temperature = weatherModel.currentWeather?.temperature ?? 0
        self.weathercode = weatherModel.currentWeather?.weathercode ?? 0
        self.maxTemp = weatherModel.dailyWeather?.temperature_2m_max.first ?? 0
        self.minTemp = weatherModel.dailyWeather?.temperature_2m_min.first ?? 0
    }
    
    public func getTemperature() -> (Int){
        let temperature: Int = Int(Float(weatherModel.currentWeather?.temperature ?? 0))
        return temperature
    }
    
    public func getMaxTemperature() -> (Int){
        let maxTemperature: Int = Int(Float(weatherModel.dailyWeather?.temperature_2m_max.first ?? 0))
        return maxTemperature
    }
    
    public func getMinTemperature() -> (Int){
        let minTemperature: Int = Int(Float(weatherModel.dailyWeather?.temperature_2m_min.first ?? 0))
        return minTemperature
    }
    
    public func getWeatherIconFromCodeForCurrent() -> (String){
        let weatherCode: Int = weatherModel.currentWeather?.weathercode ?? 0
        return TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherIcon ?? ""
    }
    
    public func getWeatherDescriptionFromCodeForCurrent() -> (String){
        let weatherCode: Int = weatherModel.currentWeather?.weathercode ?? 0
        return TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherDescription ?? ""
    }
    
}


