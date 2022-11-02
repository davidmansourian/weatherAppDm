//
//  WeatherData.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//
//"current_weather":{"temperature":10.5,"windspeed":11.4,"winddirection":169.0,"weathercode":3,"time":"2022-11-02T16:00"},"hourly_units":{"time":"iso8601","temperature_2m":"°C","rain":"mm","showers":"mm","snowfall":"cm","weathercode":"wmo code","cloudcover":"%","cloudcover_low":"%","cloudcover_mid":"%","cloudcover_high":"%"}
import Foundation

public final class WeatherService: NSObject{
    
}

struct WeatherData: Decodable{
    let weathercode: Int
    
    let temperature: Float
    let temperature_2m: Float
    let temperature_2m_max: Float
    let temperature_2m_min: Float
    
    let rain: Float
    let showers: Float
    let snowfall: Float
    
    let rain_sum: Float
    let showers_sum: Float
    let snowfall_sum: Float
    
    let cloudcover: Float
    let cloudcover_low: Float
    let cloudcover_mid: Float
    let cloudcover_high: Float
    
    
    let time: Date
    let sunrise: Date
    
}
