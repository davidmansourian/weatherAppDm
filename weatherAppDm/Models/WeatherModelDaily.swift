//
//  WeatherModelDaily.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import Foundation

public struct WeatherModelDaily{
    let date: Date
    let temperature: String
    

    init(response: WeatherResponse){
        date = response.daily.time
        temperature = "\(response.daily.temperature)" + response.hourly_units.temperature_2m
    }
}
