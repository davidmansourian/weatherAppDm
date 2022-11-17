//
//  WeatherViewModelCurrent.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation


class WeatherViewModelCurrent: ObservableObject{
    private var currentViewModelToken: Cancellable?
    private var dailyViewModelToken: Cancellable?
    private var cityLocationToken: Cancellable?
    private var cityNameToken: Cancellable?
    private let weatherModel: MainWeatherAppModel
    @Published var temperature: Int?
    @Published var maxTemp: [Float]?
    @Published var minTemp: [Float]?
    @Published var weatherCode: Int?
    @Published var weatherCodeDescription: String?
    @Published var cityLocation: CLLocation?
    @Published var cityName: String?
    
    init(weatherModel: MainWeatherAppModel){
        self.weatherModel = weatherModel
        currentViewModelToken = weatherModel.$currentWeather
            .print("debugging")
            .sink(receiveCompletion: { completion in
                print("Has completed", completion)
            }, receiveValue: { [weak self] weather in
                print("hej")
                if let weather{
                    self?.temperature = Int(weather.temperature)
                    self?.weatherCode = weather.weathercode
                    
                }
            })
        
        dailyViewModelToken = weatherModel.$dailyWeather
            .sink(receiveCompletion: {completion in
                print(completion)
            }, receiveValue: {[weak self] theDailyWeather in
                self?.maxTemp = theDailyWeather?.temperature_2m_max
                self?.minTemp = theDailyWeather?.temperature_2m_min
            })
        
        cityNameToken = weatherModel.$cityName
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self]
                theName in
                if theName != nil{
                    self?.cityName = theName
                }
            })
        
        
        cityLocationToken = weatherModel.$location
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self] location in
                if let location{
                    self?.cityLocation = location
                }
            })
    }
}
