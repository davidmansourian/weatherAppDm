//
//  WeatherData.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//
//Watched tutorial https://www.youtube.com/watch?v=DxYAhXLtAB0

import CoreLocation
import Foundation

 
//https://api.open-meteo.com/v1/forecast?latitude=59.3328&longitude=18.0645&hourly=temperature_2m,rain,showers,snowfall,weathercode,cloudcover,cloudcover_low,cloudcover_mid,cloudcover_high&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,rain_sum,showers_sum,snowfall_sum&current_weather=true&timezone=auto
    



struct WeatherResponse: Codable{
    let current_weather: WeatherForecast.CurrentWeather
}

struct WeatherForecast: Codable{
    struct CurrentWeather: Codable{
        let temperature: Float
        let time: Date
    }
}
