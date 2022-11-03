//
//  WeatherService.swift
//  weatherAppDm
//
//  Created by David on 2022-11-03.
//

import Foundation
import Combine

class APILoader: ObservableObject{
    private let urlString = "https://api.open-meteo.com/v1/forecast?latitude=59.3328&longitude=18.0645&hourly=temperature_2m,rain,showers,snowfall,weathercode,cloudcover,cloudcover_low,cloudcover_mid,cloudcover_high&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,rain_sum,showers_sum,snowfall_sum&current_weather=true&timezone=auto"
    private var cancellable: Cancellable?
    private let jsonDecoder = JSONDecoder()
    
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeather: HourlyWeather?
    @Published var dailyWeather: DailyWeather?

    
    func getWeather(){
        guard let url = URL(string: urlString )
        else{
            print("Invalid URL")
            return
        }
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap{element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode < 400
                else{
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: WeatherResponse.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: {[weak self] data in
                self?.currentWeather = data.current_weather
                self?.hourlyWeather = data.hourly
                self?.dailyWeather = data.daily
            })
    }
}
