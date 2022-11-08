////
////  WeatherViewModelDaily.swift
////  weatherAppDm
////
////  Created by David on 2022-11-07.
////
//
//import Foundation
//
//class WeatherViewModelDaily: ObservableObject{
//
//
//    private var weatherModel = APILoader()
//
//    func datesRange(from: Date, to: Date) -> [Date] {
//        // in case of the "from" date is more than "to" date,
//        // it should returns an empty array:
//        if from > to { return [Date]() }
//
//        var tempDate = from
//        var array = [tempDate]
//
//        while tempDate < to {
//            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
//            array.append(tempDate)
//        }
//
//        return array
//    }
//
//
//    func getDailyMaxTemp() -> [String]{
//        var dailyMaxTemp: [String] = []
//        for temp in weatherModel.dailyWeather?.temperature_2m_max ?? []{
//            dailyMaxTemp.append(String(temp))
//        }
//        return dailyMaxTemp
//    }
//
//    func getDailyMinTemp() -> [String]{
//        var dailyMinTemp: [String] = []
//        for temp in weatherModel.dailyWeather?.temperature_2m_min ?? []{
//            dailyMinTemp.append(String(temp))
//        }
//        return dailyMinTemp
//    }
//
//    func getDailyAvgTemp() -> [String]{
//        var dailyAvgTemp: [String] = []
//        for i in 0...6{
//            let dailyMaxTemp: Int = Int(getDailyMaxTemp()[i]) ?? 0
//            let dailyMinTemp: Int = Int(getDailyMinTemp()[i]) ?? 0
//            let dailyAvgIntTemp = dailyMaxTemp + dailyMinTemp
//            dailyAvgTemp.append(String(dailyAvgIntTemp))
//        }
//        return dailyAvgTemp
//    }
//
//    func getDailyImgString() -> [String]{
//        var dailyImgString: [String] = []
//        for img in weatherModel.dailyWeather?.weathercode ?? []{
//            dailyImgString.append(TranslatedWeathercodes().weatherCodeProperties[img]?.weatherIcon ?? "")
//        }
//        return dailyImgString
//    }
//
//    func getDayName() -> [String]{
//        let date = Date()
//        let nextSixDays = Calendar.current.date(byAdding: .day, value: 6, to: date)!
//
//        var dayName: [String] = []
//        dayName.append("Today")
//        for day in datesRange(from: date, to: nextSixDays){
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "EE"
//            let formattedDay = dateFormatter.string(from: day)
//            dayName.append(formattedDay)
//        }
//        return dayName
//    }
//
//
//        func buildWeatherStruct(){
//    //        let todaysTemperature: Int = Int(Float(weatherModel.currentWeather?.temperature ?? 0))
//    //        let todaysWeatherCode: Int = weatherModel.currentWeather?.weathercode ?? 0
//    //
//
//    //        weatherStack.append(Forecast(id: 0, temperature: String(todaysTemperature), image: TranslatedWeathercodes().weatherCodeProperties[todaysWeatherCode]?.weatherIcon ?? "", day: "Today"))
//            for i in 0...6{
//                forecast.append(Forecast(temperature: getDailyAvgTemp()[i], image: getDailyImgString()[i], day: getDayName()[i]))
//            }
//        }
//}
