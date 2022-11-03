//
//  WeatherModelCurrent.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import Foundation

public struct WeatherModelCurrent{
    let temperature: String
    let time: String
    
    init(response: WeatherResponse){
        temperature = "\(Float(response.current_weather.temperature))"
        time = response.current_weather.time
    }
}
