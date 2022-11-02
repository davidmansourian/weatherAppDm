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
    let latitude: Double
    let longitude: Double
    let current_weather: WeatherDataCurrent
    let hourly_units: WeatherDataHourlyUnits
    let hourly: WeatherDataHourly
    let daily: WeatherDataDaily
}

struct WeatherDataCurrent: Decodable{
    let temperature: Float
    let weathercode: Int
    let time: Date
}

struct WeatherDataHourlyUnits: Decodable{
    let time: Date
    
    let temperature_2m: String
    
    let rain: String
    let showers: String
    let snowfall: String
    
    let cloudcover: String
    let cloudcover_low: String
    let cloudcover_mid: String
    let cloudcover_high: String
}

struct WeatherDataHourly: Decodable{
    let time: Date
    let temperature_2m: Float
    
    let rain: Float
    let showers: Float
    let snowfall: Float
    
    let weathercode: Int
    
    let cloudcover: Int
    let cloudcover_low: Int
    let cloudcover_mid: Int
    let cloudcover_high: Int
}

struct WeatherDataDailyUnits: Decodable{
    let time: Date
    
    let weathercode: Int
    
    let temperature_2m_max: String
    let temperature_2m_min: String
    
    let sunrise: Date
    let sunset: Date
    
    let rain_sum: String
    let showers_sum: String
    let snowfall_sum: String
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
