//
//  WeatherViewModelHourly.swift
//  weatherAppDm
//
//  Created by David on 2022-11-03.
//

import Foundation
import Combine


class WeatherViewModelHourly: ObservableObject{
    private var weatherModel = MainWeatherAppModel()
    private var hourlyViewModelToken: Cancellable?
    @Published var temperature: [Float]?
    @Published var weatherCode: [Int]?
    @Published var date: [String]?
    
    
    init(){
        hourlyViewModelToken = weatherModel.$hourlyWeather
            .sink(receiveCompletion: {completion in
                print(completion)
            }, receiveValue: {[weak self] theHourlyWeather in
                self?.temperature = theHourlyWeather?.temperature_2m
                self?.weatherCode = theHourlyWeather?.weathercode
                self?.date = theHourlyWeather?.time
            })
    }
    
    func getTemperatureForI() -> ([Int]){
         var temperatures: [Int] = []
         for temp in weatherModel.hourlyWeather?.temperature_2m.dropFirst(getIndexForHour()) ?? [0]{
             if temperatures.count < 21{
                 let temperature: Int = Int(Float(temp))
                 temperatures.append(temperature)
             }
             else { break }
             
         }
         return temperatures
     }
     
//     func getTimeForI() -> ([String]){
//         var times: [String] = []
//         for time in weatherModel.hourlyWeather?.time ?? [""]{
//             times.append(time)
//         }
//         print("weatherModelTimearr: ", weatherModel.hourlyWeather?.time ?? [""])
//         print("getTimeForI: ", times)
//         return times
//     }
     
     func getCurrentTime() -> (String){ // returns the current hour so that the time forecast can show relevant times
         let date = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "YY, MMM d, HH:mm"
         let dateString = dateFormatter.string(from: date).dropFirst(13).dropLast(3)
         return String(dateString)

     }
     
     func getIndexForHour() -> (Int){
         
         let times: [String] = self.date ?? [""]
         for (index, time) in times.enumerated(){
             let desiredStringTwo = time.dropFirst(11).dropLast(3)
             //print("desiredTwo:"+desiredStringTwo, "vs. ", "getCurrentTime:"+getCurrentTime())
             if desiredStringTwo == getCurrentTime(){
                 print("INDEEEX FOR HOUR: ", index)
                 return index
             }
         }
         return 0
     }
     
     func getAccurateIndexedTimeArray() -> [String]{
         let times: [String] = self.date ?? [""]
//         let times: [String] = weatherModel.hourlyWeather?.time ?? [""]
         var arr: [String] = []
         for time in times.dropFirst(getIndexForHour()){
             if arr.count < 20{
                 arr.append(time)
             }
             else{ break }
         }
         return arr
     }
    
}
