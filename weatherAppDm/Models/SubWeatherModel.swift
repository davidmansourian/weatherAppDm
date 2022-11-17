//
//  SubWeatherModel.swift
//  weatherAppDm
//
//  Created by David on 2022-11-11.
//

import Foundation
import CoreLocation
import Combine
import MapKit


class SubWeatherModdel: ObservableObject{
    private var currentWeatherDataToken: Cancellable?
    private var hourlyWeatherDataToken: Cancellable?
    private var dailyWeatherDataToken: Cancellable?
    private var mapServiceToken: Cancellable?
    private var subGeoCoderToken: Cancellable?
    private var requestedLocationToken: Cancellable?
    private var cityNameToken: Cancellable?
    @Published var mapSearch = MapSearch()
    @Published var locationResults: [MKLocalSearchCompletion]?
    var subCurrentWeatherVM: SubViewModelCurrent?
    var subDailyWeatherVM: WeatherSubViewModelDaily?
    var subHourlyWeatherVM: SubViewModelHourly?
    var subSearchResultVM: SearchResultViewModel?
    @Published var subWeatherService = APILoader()
    @Published var mainGeoCoder = GeoCodeService()
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeather: HourlyWeather?
    @Published var dailyWeather: DailyWeather?
    @Published var location: CLLocation?
    @Published var cityName: String?
    
    init(){
        subCurrentWeatherVM = SubViewModelCurrent(weatherModel: self)
        subDailyWeatherVM = WeatherSubViewModelDaily(weatherModel: self)
        subHourlyWeatherVM = SubViewModelHourly(weatherModel: self)
        
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
        
        cityNameToken = subWeatherService.$cityName
            .sink(receiveCompletion: {completion in}, receiveValue: {[weak self]
                theName in
                if let theName{
                    self?.cityName = theName
                }
            })
    }
        
}
