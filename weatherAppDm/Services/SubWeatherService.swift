//
//  SubWeatherService.swift
//  weatherAppDm
//
//  Created by David on 2022-11-10.
//

import Foundation
import Combine
import CoreLocation


class SubWeatherService: ObservableObject{
    
    private var cancellable: Cancellable?
    private let jsonDecoder = JSONDecoder()
    private var locationToken: Cancellable?
    @Published var subCurrentWeather: SubCurrentWeather?
    @Published var subHourlyWeather: SubHourlyWeather?
    @Published var subDailyWeather: SubDailyWeather?
    let geoCoder = CLGeocoder()
    @Published var subCityName: String?
    
    // store and reuse location
    //use guard statement
    
    
// getCiyName-function below was inspired by https://stackoverflow.com/questions/49276052/unable-to-get-city-name-by-current-latitude-and-longitude-in-swift
    func getCityName(latitude: Double?, longitude: Double?){
        guard (latitude != nil) || (longitude != nil) else{
            print("ERROR WITH INPARAMTER")
            return
        }
        let location = CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            for placemark in placemarks ?? []{
                if let city = placemark.locality{
                    self.subCityName = city
                }
            }
        })
    }
    
    func getWeather(latitude: Double?, longitude: Double?){
        print("cityname: " + (subCityName ??  "-"))
        print("latitude:  \(latitude)" + " longitude: \(longitude)")
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude ?? 00)&longitude=\(longitude ?? 00)&hourly=temperature_2m,rain,showers,snowfall,weathercode,cloudcover,cloudcover_low,cloudcover_mid,cloudcover_high&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,rain_sum,showers_sum,snowfall_sum&current_weather=true&timezone=auto"
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
            .decode(type: SubWeatherResponse.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: {[weak self] data in
                self?.subCurrentWeather = data.current_weather
                self?.subHourlyWeather = data.hourly
                self?.subDailyWeather = data.daily
            })
    }
}
