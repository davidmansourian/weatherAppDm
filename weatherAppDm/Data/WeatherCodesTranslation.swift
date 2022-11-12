//
//  WeatherCodesTranslation.swift
//  weatherAppDm
//
//  Created by David on 2022-11-03.
//

import Foundation
import SwiftUI

struct WeatherCode : Hashable{
    let code: Int
    let weatherIcon: String
    let weatherDescription: String
}

class TranslatedWeathercodes: ObservableObject{
    let weatherCodeProperties = [0: WeatherCode(code: 0, weatherIcon: "sun.max.fill", weatherDescription: "Clear skies and sun"),
                                 1: WeatherCode(code: 1, weatherIcon: "cloud.sun.fill", weatherDescription: "Mainly clear"),
                                 2: WeatherCode(code: 2, weatherIcon: "cloud.sun.fill", weatherDescription: "Partly Cloudy"),
                                 3: WeatherCode(code: 3, weatherIcon: "cloud.fill", weatherDescription: "Overcast"),
                                 45: WeatherCode(code: 45, weatherIcon: "cloud.fog.fill", weatherDescription: "Fog"),
                                 48: WeatherCode(code: 45, weatherIcon: "cloud.fog.fill", weatherDescription: "Fog"),
                                 51: WeatherCode(code: 51, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Light drizzle"),
                                 53: WeatherCode(code: 53, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Moderate drizzle"),
                                 55: WeatherCode(code: 55, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Dense drizzle"),
                                 56: WeatherCode(code: 56, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Light freezing drizzle"),
                                 57: WeatherCode(code: 57, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Dense freezing drizzle"),
                                 61: WeatherCode(code: 61, weatherIcon: "cloud.rain.fill", weatherDescription: "Slight rain"),
                                 63: WeatherCode(code: 63, weatherIcon: "cloud.rain.fill", weatherDescription: "Moderate rain"),
                                 65: WeatherCode(code: 65, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Heavy rain"),
                                 66: WeatherCode(code: 66, weatherIcon: "cloud.rain.fill", weatherDescription: "Light freezing rain"),
                                 67: WeatherCode(code: 67, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Heavy frezing rain"),
                                 71: WeatherCode(code: 71, weatherIcon: "cloud.snow.fill", weatherDescription: "Light snow"),
                                 73: WeatherCode(code: 73, weatherIcon: "cloud.snow.fill", weatherDescription: "Moderate snow"),
                                 75: WeatherCode(code: 75, weatherIcon: "cloud.snow.fill", weatherDescription: "Heavy snow"),
                                 77: WeatherCode(code: 77, weatherIcon: "snow.fill", weatherDescription: "Snow grains"),
                                 80: WeatherCode(code: 80, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Slight rain showers"),
                                 81: WeatherCode(code: 81, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Moderate rain showers"),
                                 82: WeatherCode(code: 82, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Violen rain showers"),
                                 95: WeatherCode(code: 95, weatherIcon: "cloud.bolt.fill", weatherDescription: "Thunderstorm, slight or moderate"),
                                 96: WeatherCode(code: 96, weatherIcon: "cloud.bolt.fill", weatherDescription: "Thunderstorm with slight hail"),
                                 99: WeatherCode(code: 99, weatherIcon: "cloud.bolt.fill", weatherDescription: "Thunderstorm with heavy hail")]
    
    let backGroundForWeatherCode = [0: LinearGradient(gradient: Gradient(colors:[.yellow,.blue,.blue]), startPoint: .topTrailing, endPoint:         .bottomLeading),
                                    1: LinearGradient(gradient: Gradient(colors:[.white,.blue,.blue]), startPoint: .topTrailing, endPoint: .bottomLeading),
                                    2: LinearGradient(gradient: Gradient(colors:[.white,.gray,.gray]), startPoint: .topTrailing, endPoint: .bottomLeading),
                                    3: LinearGradient(gradient: Gradient(colors:[.gray,.gray,.gray]), startPoint: .topTrailing, endPoint: .bottomLeading)]
    //                                 45: WeatherCode(code: 45, weatherIcon: "cloud.fog.fill", weatherDescription: "Fog"),
    //                                 48: WeatherCode(code: 45, weatherIcon: "cloud.fog.fill", weatherDescription: "Fog"),
    //                                 51: WeatherCode(code: 51, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Light drizzle"),
    //                                 53: WeatherCode(code: 53, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Moderate drizzle"),
    //                                 55: WeatherCode(code: 55, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Dense drizzle"),
    //                                 56: WeatherCode(code: 56, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Light freezing drizzle"),
    //                                 57: WeatherCode(code: 57, weatherIcon: "cloud.drizzle.fill", weatherDescription: "Dense freezing drizzle"),
    //                                 61: WeatherCode(code: 61, weatherIcon: "cloud.rain.fill", weatherDescription: "Slight rain"),
    //                                 63: WeatherCode(code: 63, weatherIcon: "cloud.rain.fill", weatherDescription: "Moderate rain"),
    //                                 65: WeatherCode(code: 65, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Heavy rain"),
    //                                 66: WeatherCode(code: 66, weatherIcon: "cloud.rain.fill", weatherDescription: "Light freezing rain"),
    //                                 67: WeatherCode(code: 67, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Heavy frezing rain"),
    //                                 71: WeatherCode(code: 71, weatherIcon: "cloud.snow.fill", weatherDescription: "Light snow"),
    //                                 73: WeatherCode(code: 73, weatherIcon: "cloud.snow.fill", weatherDescription: "Moderate snow"),
    //                                 75: WeatherCode(code: 75, weatherIcon: "cloud.snow.fill", weatherDescription: "Heavy snow"),
    //                                 77: WeatherCode(code: 77, weatherIcon: "snow.fill", weatherDescription: "Snow grains"),
    //                                 80: WeatherCode(code: 80, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Slight rain showers"),
    //                                 81: WeatherCode(code: 81, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Moderate rain showers"),
    //                                 82: WeatherCode(code: 82, weatherIcon: "cloud.heavyrain.fill", weatherDescription: "Violen rain showers"),
    //                                 95: WeatherCode(code: 95, weatherIcon: "cloud.bolt.fill", weatherDescription: "Thunderstorm, slight or moderate"),
    //                                 96: WeatherCode(code: 96, weatherIcon: "cloud.bolt.fill", weatherDescription: "Thunderstorm with slight hail"),
    //                                 99: WeatherCode(code: 99, weatherIcon: "cloud.bolt.fill", weatherDescription: "Thunderstorm with heavy hail")]
}




//WeatherCode(code: 0, weatherIcon: "sun.max", weatherDescription: "Clear skies and sun")
//WeatherCode(code: 1, weatherIcon: "cloud.sun", weatherDescription: "Mainly clear")
//WeatherCode(code: 2, weatherIcon: "cloud.sun", weatherDescription: "Partly Cloudy")
//WeatherCode(code: 3, weatherIcon: "cloud", weatherDescription: "Overcast")
//WeatherCode(code: 45, weatherIcon: "cloud.fog", weatherDescription: "Fog")
//WeatherCode(code: 48, weatherIcon: "cloud.fog", weatherDescription: "Depositing rime fog")
//WeatherCode(code: 51, weatherIcon: "cloud.drizzle", weatherDescription: "Light drizzle")
//WeatherCode(code: 53, weatherIcon: "cloud.drizzle", weatherDescription: "Moderate drizzle")
//WeatherCode(code: 55, weatherIcon: "cloud.drizzle", weatherDescription: "Dense drizzle")
//WeatherCode(code: 56, weatherIcon: "cloud.drizzle", weatherDescription: "Light freezing drizzle")
//WeatherCode(code: 57, weatherIcon: "cloud.drizzle", weatherDescription: "Dense freezing drizzle")
//WeatherCode(code: 61, weatherIcon: "cloud.rain", weatherDescription: "Slight rain")
//WeatherCode(code: 63, weatherIcon: "cloud.rain", weatherDescription: "Moderate rain")
//WeatherCode(code: 65, weatherIcon: "cloud.heavyrain", weatherDescription: "Heavy rain")
//WeatherCode(code: 66, weatherIcon: "cloud.rain", weatherDescription: "Light freezing rain")
//WeatherCode(code: 67, weatherIcon: "cloud.heavyrain", weatherDescription: "Heavy frezing rain")
//WeatherCode(code: 71, weatherIcon: "cloud.snow", weatherDescription: "Light snow")
//WeatherCode(code: 73, weatherIcon: "cloud.snow", weatherDescription: "Moderate snow")
//WeatherCode(code: 75, weatherIcon: "cloud.snow", weatherDescription: "Heavy snow")
//WeatherCode(code: 77, weatherIcon: "snow", weatherDescription: "Snow grains")
//WeatherCode(code: 80, weatherIcon: "cloud.heavyrain", weatherDescription: "Slight rain showers")
//WeatherCode(code: 81, weatherIcon: "cloud.heavyrain", weatherDescription: "Moderate rain showers")
//WeatherCode(code: 82, weatherIcon: "cloud.heavyrain", weatherDescription: "Violen rain showers")
//WeatherCode(code: 95, weatherIcon: "cloud.bolt", weatherDescription: "Thunderstorm, slight or moderate")
//WeatherCode(code: 96, weatherIcon: "cloud.bolt", weatherDescription: "Thunderstorm with slight hail")
//WeatherCode(code: 99, weatherIcon: "cloud.bolt", weatherDescription: "Thunderstorm with heavy hail")
