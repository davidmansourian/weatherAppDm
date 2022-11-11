//
//  SubViewModelCurrent.swift
//  weatherAppDm
//
//  Created by David on 2022-11-11.
//

import Foundation
import Combine

class WeatherViewSubModelCurrent: ObservableObject{
    private var currentSubViewModelToken: Cancellable?
    private var dailySubViewModelToken: Cancellable?
    private var currentWeather = SubWeatherModel()
    @Published var temperature: Int?
    @Published var maxTemp: [Float]?
    @Published var minTemp: [Float]?
    @Published var weatherCode: Int?
    @Published var weatherCodeDescription: String?
    
    init(){
        currentSubViewModelToken = currentWeather.$currentWeather
            .print("debugging")
            .sink(receiveCompletion: { completion in
                print("Has completed", completion)
            }, receiveValue: { [weak self] subWeather in
                print("hej")
                if let subWeather{
                    print("sub Temperature: ", subWeather.temperature)
                    print("sub weathercode: ", subWeather.weathercode)
                    self?.temperature = Int(subWeather.temperature)
                    self?.weatherCode = subWeather.weathercode
                    
                    
                }
            })
        
        dailySubViewModelToken = currentWeather.$dailyWeather
            .sink(receiveCompletion: {completion in
                print(completion)
            }, receiveValue: {[weak self] theDailyWeather in
                self?.maxTemp = theDailyWeather?.temperature_2m_max
                self?.minTemp = theDailyWeather?.temperature_2m_min
            })
    }
    
//    func getsubCurrentWeather(latitude: Double?, longitude: Double?){
//        currentWeather.getWeather(latitude: latitude, longitude: longitude)
//    }
}
