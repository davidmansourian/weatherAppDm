//
//  WeatherModelCurrent.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import Foundation

public struct WeatherModelCurrent{
    let temperature: String
//    let temperature_high: String
//    let temperature_low: String
    
    init(response: WeatherResponse){
        temperature = "\(Float(response.current_weather.temperature))"
//        temperature_high = "\(response.[daily.temperature_2m_max])"
//        temperature_low = "\(response.daily.temperature_2m_min)"
    }
}
