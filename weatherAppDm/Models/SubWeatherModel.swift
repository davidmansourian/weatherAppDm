//
//  SubWeatherModel.swift
//  weatherAppDm
//
//  Created by David on 2022-11-11.
//

import Foundation
import CoreLocation
import Combine

class SubWeatherModel: ObservableObject{
    private var currentWeatherDataToken: Cancellable?
    private var hourlyWeatherDataToken: Cancellable?
    private var dailyWeatherDataToken: Cancellable?
    private var subGeoCoderToken: Cancellable?
    private var requestedLocationToken: Cancellable?
    
    @Published var subWeatherService = APILoader()
    @Published var subGeoCoder = GeoCodeService()
    
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeather: HourlyWeather?
    @Published var dailyWeather: DailyWeather?
    @Published var cityName: String?
    
    init(){
        currentWeatherDataToken = subWeatherService.$currentWeather
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self] currentWeatherData in
                if let currentWeatherData{
                    self?.currentWeather = currentWeatherData
                }
            })
        hourlyWeatherDataToken = subWeatherService.$hourlyWeather
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self]
                hourlyWeatherData in
                if let hourlyWeatherData{
                    self?.hourlyWeather = hourlyWeatherData
                }
            })
        
        dailyWeatherDataToken = subWeatherService.$dailyWeather
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self]
                dailyWeatherData in
                if let dailyWeatherData{
                    self?.dailyWeather = dailyWeatherData
                }
            })
        
        requestedLocationToken = SearchResultViewModel.shared.$chosenLocation
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self]
                theLocation in
                    self?.subWeatherService.getWeather(latitude: theLocation.latitude, longitude: theLocation.longitude)
            })
        
        
//        subGeoCoderToken = subGeoCoder.$cityName
//            .sink(receiveCompletion: {completion in}, receiveValue: {geoCoderData in
//                if let geoCoderData{
//                    self.cityName = geoCoderData
//                }
//            })
    }
}
