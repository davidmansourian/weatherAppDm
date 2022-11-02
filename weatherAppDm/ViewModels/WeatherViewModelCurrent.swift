//
//  WeatherViewModelCurrent.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import Foundation

class WeatherViewModelCurrent: ObservableObject{
    @Published var city: String = "Jönköping"
    @Published var temperature: String = "--"
    @Published var temperatureHigh: String = "--"
    @Published var temperatureLow: String = "--"
    
    public let weatherLocationHandler: WeatherLocationHandler
    
    init(weatherLocationHandler: WeatherLocationHandler){
        self.weatherLocationHandler = weatherLocationHandler
    }
    
     func refresh(){
        weatherLocationHandler.loadWeatherData{ weatherCurrent in
            DispatchQueue.main.async {
                self.city = "Tjena"
                self.temperature = "\(weatherCurrent.temperature)"
//                self.temperatureHigh = weatherCurrent.temperature_high
//                self.temperatureLow = weatherCurrent.temperature_low
            }
        }
    }
}
