//
//  WeatherModelHourly.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import Foundation

public struct WeatherModelHourly{
    let time: Date
    let temperature: String
    
    init(response: WeatherResponse){
        time = response.hourly.time
        temperature = "\(response.hourly.temperature_2m)" + response.hourly_units.temperature_2m
    }
}
