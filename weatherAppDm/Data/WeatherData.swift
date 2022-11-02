//
//  WeatherData.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//
//Implementation based on https://www.youtube.com/watch?v=DxYAhXLtAB0

import CoreLocation
import Foundation

public final class WeatherService: NSObject{
    private let locationManager = CLLocationManager()
    private var completionHandler: (())
}

struct response{
    let city: String
    let hourly: WeatherDataHourly
    let daily: WeatherDataDaily
}

struct WeatherDataHourly: Decodable{
    let weathercode: Int
    
    let time: Date
    let temperature_2m: Float
    
    let rain: Float
    let showers: Float
    let snowfall: Float
    
    let cloudcover: Float
    let cloudcover_low: Float
    let cloudcover_mid: Float
    let cloudcover_high: Float
}

struct WeatherDataDaily: Decodable{
    let weathercode: Int
    
    let time: Date
    
    let temperature: Float
    let temperature_2m_max: Float
    let temperature_2m_min: Float
    
    let sunrise: Date
    let sunset: Date
    
    let rain_sum: Float
    let showers_sum: Float
    let snowfall_sum: Float
}
