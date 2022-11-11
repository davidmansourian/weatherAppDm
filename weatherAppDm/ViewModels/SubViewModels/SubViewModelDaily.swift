//
//  SubViewModelDaily.swift
//  weatherAppDm
//
//  Created by David on 2022-11-11.
//

import Foundation
import Combine

class WeatherSubViewModelDaily: ObservableObject{


    private var dailyWeather = SubWeatherModel()
    private var subDailyViewModelToken: Cancellable?
    @Published var date: [String]?
    @Published var maxTemp: [Float]?
    @Published var minTemp: [Float]?
    @Published var weatherCode: [Int]?
    
    init(){
        subDailyViewModelToken = dailyWeather.$dailyWeather
            .sink(receiveCompletion: {completion in
                print(completion)
            }, receiveValue: {[weak self] theDailyWeather in
                self?.date = theDailyWeather?.time
                self?.maxTemp = theDailyWeather?.temperature_2m_max
                self?.minTemp = theDailyWeather?.temperature_2m_min
                self?.weatherCode = theDailyWeather?.weathercode
            })
    }
    
    
    
    
    
    
    
    // Below function is created by Ahmad F and is used from https://stackoverflow.com/questions/49387344/how-to-get-an-array-of-days-between-two-dates-in-swift
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }

        return array
    }
    
    
//    func getDailyMaxTemp() -> [Float]{
//        var dailyMaxTemp: [Float] = []
//        for i in 0...6{
//            dailyMaxTemp.append(weatherModel.dailyWeather?.temperature_2m_max[i] ?? 00)
//        }
//        return dailyMaxTemp
//    }
//
//    func getDailyMinTemp() -> [Float]{
//        var dailyMinTemp: [Float] = []
//        for i in 0...6{
//            dailyMinTemp.append(weatherModel.dailyWeather?.temperature_2m_min[i] ?? 0)
//        }
//        return dailyMinTemp
//    }
    
    func getDailyAvgTemp() -> [String]{
        var dailyAvgTemp: [String] = []
        for i in 0...6{
            let avgFloatTemp = ((self.minTemp?[i] ?? 0) + (self.maxTemp?[i] ?? 0))/2
            let avgIntTemp: Int = Int(avgFloatTemp)
            dailyAvgTemp.append(String(avgIntTemp))
        }
        return dailyAvgTemp
    }
    
    func getDailyImgString() -> [Int]{
        var dailyImgString: [Int] = []
        for i in 0...6{
            dailyImgString.append(self.weatherCode?[i] ?? 0)
        }
        return dailyImgString
    }
    
    func getDayName() -> [String]{
        let date = Date()
        let nextSixDays = Calendar.current.date(byAdding: .day, value: 6, to: date)!
        
        var dayName: [String] = []
        for day in datesRange(from: date, to: nextSixDays){
            if day == date{
                dayName.append("Today")
            }
            else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EE"
                let formattedDay = dateFormatter.string(from: day)
                dayName.append(formattedDay)
            }
        }
        return dayName
    }
}
