//
//  ForecastView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct Forecast: Hashable{
    let id: Int
    let temperature: String
    let image: String
    let day: String
}

struct ForecastView: View {


    
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
    
    
    func getDailyMaxTemp() -> [Float]{
        var dailyMaxTemp: [Float] = []
        for i in 0...6{
            dailyMaxTemp.append(weatherModel.dailyWeather?.temperature_2m_max[i] ?? 00)
        }
        return dailyMaxTemp
    }
//
    func getDailyMinTemp() -> [Float]{
        var dailyMinTemp: [Float] = []
        for i in 0...6{
            dailyMinTemp.append(weatherModel.dailyWeather?.temperature_2m_min[i] ?? 0)
        }
        return dailyMinTemp
    }
    
    func getDailyAvgTemp() -> [String]{
        var dailyAvgTemp: [String] = []
        for i in 0...6{
            let avgFloatTemp = (getDailyMinTemp()[i] + getDailyMaxTemp()[i])/2
            let avgIntTemp: Int = Int(avgFloatTemp)
            dailyAvgTemp.append(String(avgIntTemp))
        }
        return dailyAvgTemp
    }
    
    func getDailyImgString() -> [Int]{
        var dailyImgString: [Int] = []
        for i in 0...6{
            dailyImgString.append(weatherModel.dailyWeather?.weathercode[i] ?? 0)
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

    
//     func pushWeather() -> [Forecast]{
//         var weatherForecast: [Forecast] = []
//        for i in 0...6{
//            let dayName = getDayName()[i]
//            print("dayName: " + dayName)
//            let imgName = getDailyImgString()[i]
//            weatherForecast.append(Forecast(id: i, temperature: "10", image: imgName, day: dayName))
//        }
//        return weatherForecast
//    }
//
    
    
//    mutating func buildWeatherStruct(){
//    //        let todaysTemperature: Int = Int(Float(weatherModel.currentWeather?.temperature ?? 0))
//    //        let todaysWeatherCode: Int = weatherModel.currentWeather?.weathercode ?? 0
//    //
//
//    //        weatherStack.append(Forecast(id: 0, temperature: String(todaysTemperature), image: TranslatedWeathercodes().weatherCodeProperties[todaysWeatherCode]?.weatherIcon ?? "", day: "Today"))
//            for i in 0...6{
//                forecast.append(Forecast(temperature: getDailyAvgTemp()[i], image: getDailyImgString()[i], day: getDayName()[i]))
//            }
//        }
    
    
    
    

    
    // viewModel should send data to here
    @StateObject private var weatherModel = APILoader()
    @StateObject private var locationManager = LocationManager.shared
    // Below function is created by Ahmad F and is used from https://stackoverflow.com/questions/49387344/how-to-get-an-array-of-days-between-two-dates-in-swift

    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    let rows = [GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 10){
            ZStack{
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 365, height: 500)
                    .cornerRadius(15)
                HStack {
                    Text("7 Day Forecast")
                        .offset(y: -230)
                        .foregroundColor(Color.white)
                        .font(Font.footnote)
                }
                Divider()
                    .frame(width: 365)
                    .offset(y: -210)
                LazyVGrid(columns: columns, spacing: 30){
                    ForEach(0...6, id: \.self){ day in
                        Text(getDayName()[day])
                            .foregroundColor(Color.white)
                        Image(systemName: TranslatedWeathercodes().weatherCodeProperties[getDailyImgString()[day]]?.weatherIcon ?? "")
                            .foregroundColor(Color.white)
                        Text(getDailyAvgTemp()[day])
                            .foregroundColor(Color.white)
                        
//                        Divider() LazyVGrid divider multiple column foreach
                    }
                }
            }
        }
        .onAppear(){
            weatherModel.getWeather()
                
        }
    }
}

//Text("hej hej hej hej hej hej hej hej hej hej hej hej hej hej")
struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}


//                HStack {
//                    VStack(alignment: .leading ,spacing: 15){
//                        ForEach(days, id: \.self){ day in
//                            HStack(spacing: 100){
//                                Text(day)
//                                    .foregroundColor(Color.white)
//                                Image(systemName: "cloud")
//                                    .foregroundColor(Color.white)
//                                Text("10°")
//                                    .foregroundColor(Color.white)
//                            }
//                            Divider()
//                        }
//                        .offset(x: 23, y: 1)
//                    }
//                }
