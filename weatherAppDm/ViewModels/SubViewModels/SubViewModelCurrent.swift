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
    private var cityNameToken: Cancellable?
    private var currentWeather = SubWeatherModel()
    @Published var temperature: Int?
    @Published var maxTemp: [Float]?
    @Published var minTemp: [Float]?
    @Published var weatherCode: Int?
    @Published var weatherCodeDescription: String?
    @Published var cityName: String?
    
    init(){
        currentSubViewModelToken = currentWeather.$currentWeather
            .sink(receiveCompletion: { completion in
                print("Has completed", completion)
            }, receiveValue: { [weak self] subWeather in
                if let subWeather{
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
        
        cityNameToken = currentWeather.$cityName
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self]
                theName in
                if theName != nil{
                    self?.cityName = theName
                }
            })
        
        
    }
    
//    func getsubCurrentWeather(latitude: Double?, longitude: Double?){
//        currentWeather.getWeather(latitude: latitude, longitude: longitude)
//    }
}
