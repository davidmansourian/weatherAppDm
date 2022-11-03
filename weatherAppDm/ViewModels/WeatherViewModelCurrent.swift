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
    
    
    
}

