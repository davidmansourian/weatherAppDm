//
//  MainWeatherModel.swift
//  weatherAppDm
//
//  Created by David on 2022-11-11.
//

import Foundation
import CoreLocation
import Combine

class MainWeatherAppModel: ObservableObject{
    private var currentWeatherDataToken: Cancellable?
    private var hourlyWeatherDataToken: Cancellable?
    private var dailyWeatherDataToken: Cancellable?
    private var mainGeoCoderToken: Cancellable?
    private var mainLocationToken: Cancellable?
    private var cityNameToken: Cancellable?
    
    var currentWeatherVM: WeatherViewModelCurrent?
    var dailyWeatherVM: WeatherViewModelDaily?
    var hourlyWeatherVM: WeatherViewModelHourly?
    @Published var mainWeatherService = APILoader()
    @Published var mainGeoCoder = GeoCodeService()
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeather: HourlyWeather?
    @Published var dailyWeather: DailyWeather?
    @Published var location: CLLocation?
    @Published var cityName: String?
    
    init(){
        currentWeatherVM = WeatherViewModelCurrent(weatherModel: self)
        dailyWeatherVM = WeatherViewModelDaily(weatherModel: self)
        hourlyWeatherVM = WeatherViewModelHourly(weatherModel: self)
        currentWeatherDataToken = mainWeatherService.$currentWeather
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self] currentWeatherData in
                if let currentWeatherData{
                    self?.currentWeather = currentWeatherData
                }
            })
        hourlyWeatherDataToken = mainWeatherService.$hourlyWeather
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self]
                hourlyWeatherData in
                if let hourlyWeatherData{
                    self?.hourlyWeather = hourlyWeatherData
                }
            })
        
        dailyWeatherDataToken = mainWeatherService.$dailyWeather
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self]
                dailyWeatherData in
                if let dailyWeatherData{
                    self?.dailyWeather = dailyWeatherData
                }
            })
        
        cityNameToken = mainWeatherService.$cityName
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self]
                theName in
                if let theName{
                    self?.cityName = theName
                }
            })
        
        
//        mainGeoCoderToken = LocationManager.shared.$userLocation
//            .sink(receiveCompletion: {completion in}, receiveValue: { location in
//                print("location for city from MAinModel: ", location)
//                if let location{
//                    self.location = location
//                    print("SELF LOCATIOOOOOOOOOOOON: ", location)
//                    self.cityName = self.mainGeoCoder.getCityName(theLocation: location)
//                }
//            })
        
        mainLocationToken = LocationManager.shared.$userLocation
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self] location in
                if let location{
                    self?.mainWeatherService.getWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    self?.mainWeatherService.getCityName(theLocation: location)
                }
            })
    }
}

