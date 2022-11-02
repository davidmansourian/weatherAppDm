//
//  WeatherData.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//
//Watched tutorial https://www.youtube.com/watch?v=DxYAhXLtAB0

import CoreLocation
import Foundation

public final class WeatherService: NSObject{
    private let locationManager = CLLocationManager()
    private var completionHandler: ((WeatherModelCurrent, WeatherModelHourly, WeatherModelDaily) -> Void)? // optional property
    
    public override init(){
        
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((WeatherModelCurrent, WeatherModelHourly, WeatherModelDaily) -> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
//https://api.open-meteo.com/v1/forecast?latitude=59.3328&longitude=18.0645&hourly=temperature_2m,rain,showers,snowfall,weathercode,cloudcover,cloudcover_low,cloudcover_mid,cloudcover_high&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,rain_sum,showers_sum,snowfall_sum&current_weather=true&timezone=auto
    
    private func DataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)&hourly=temperature_2m,rain,showers,snowfall,weathercode,cloudcover,cloudcover_low,cloudcover_mid,cloudcover_high&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,rain_sum,showers_sum,snowfall_sum&current_weather=true&timezone=auto"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        guard let url = URL(string: urlString)
        else{
            return
        }
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard error == nil, let data = data
            else{
                return
            }
            if let response = try? JSONDecoder().decode(WeatherResponse.self, from: data){
                self.completionHandler?(WeatherModelCurrent(response: response), WeatherModelHourly(response: response), WeatherModelDaily(response: response))
            }
        }.resume()
    }
}

struct WeatherResponse: Decodable{
    let latitude: Double
    let longitude: Double
    let current_weather: WeatherDataCurrent
    let hourly_units: WeatherDataHourlyUnits
    let hourly: WeatherDataHourly
    let daily: WeatherDataDaily
    let daily_units: WeatherDataDailyUnits
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
