//
//  WeatherViewModelHourly.swift
//  weatherAppDm
//
//  Created by David on 2022-11-03.
//

import Foundation


class WeatherViewModelHourly: ObservableObject{
    private var weatherModel = APILoader()
    
    init(weatherModel: APILoader){
        self.weatherModel = weatherModel
    }
    
    public func getTemperature(`let` x: Int) -> (Int){
        let temperature: Int = Int(Float(weatherModel.hourlyWeather?.temperature_2m[x] ?? 0))
        return temperature
    }
    
    public func getWeatherIconFromCodeForHourly(`let` x: Int) -> (String){
        let weatherCode: Int = weatherModel.hourlyWeather?.weathercode[x] ?? 0
        return TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherIcon ?? ""
    }
    
    
}
