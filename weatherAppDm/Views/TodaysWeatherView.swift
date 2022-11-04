//
//  TodaysWeatherView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI



struct TodaysWeatherView: View {
    
    func getTemperatureForI() -> ([Int]){
        var temperatures: [Int] = []
        for temp in weatherModel.hourlyWeather?.temperature_2m ?? [0]{
            print("testing temp float: " + "\(temp)")
            let temperature: Int = Int(Float(temp))
            print("testing temp: " + "\(temperature)")
            temperatures.append(temperature)
        }
        return temperatures
    }
    
    func getTimeForI() -> ([String]){
        var times: [String] = []
        for time in weatherModel.hourlyWeather?.time ?? [""]{
            times.append(time)
        }
        return times
    }
    
    func getCurrentTime() -> (String){ // returns the current hour so that the time forecast can show relevant times
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
        let dateString = dateFormatter.string(from: date).dropFirst(10).dropLast(3)
        return String(dateString)
    }
    
    
    @StateObject private var weatherModel = APILoader()
    var body: some View {
        let temperatures: [Int] = getTemperatureForI()
        let times: [String] = getTimeForI()
        let theIndex = 0
        
        VStack(spacing: 10){
            ZStack{
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 365, height: 200)
                    .cornerRadius(15)
                Divider()
                    .frame(width: 365)
                    .offset(y: -35)
                HStack {
                    Text("Wheather info text from ViewModel. Bla Bla Bla fasdf") // create a function that
                    // calculates an average on the weathercode. Make a scoring system that mentions the
                    // most frequent code in words first, and then the second. E.g. Mostly overcast, some sun.
                        .offset(y: -70)
                        .foregroundColor(Color.white)
                        .font(Font.footnote)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(spacing: 15){
                        HStack(spacing: 26.3) {
                            ForEach(times, id: \.self){ time in
                                let desiredStringTwo = time.dropFirst(11).dropLast(3)
                                if desiredStringTwo == getCurrentTime(){
                                    // need to find solution that finds index for first matching hour
                                    // so that I know what time it is and how many hours in advance
                                    // i should show
                                }
                            }
                            ForEach(times.prefix(20), id: \.self) { time in
                                let desiredStringTwo = time.dropFirst(11).dropLast(3)
                                Text(getCurrentTime())
                                    .frame(width: 46, height: 30)
                                    .bold()
                                    .font(.system(size: 13))
                                    .foregroundColor(Color.white) // add sunset and sunrise to distinct days
                            }
                            
//                            ForEach(times.prefix(20), id: \.self){ time in
//                                Text(time[12] + time[13])
//                                    .frame(width: 46, height:30)
//                                    .bold()
//                                    .font(.system(size: 13))
//                                    .foregroundColor(Color.white)
//                            }
                        }
                        HStack(spacing: 49.4){
                            ForEach(0...19, id: \.self){ i in
                                let weatherCode: Int = weatherModel.hourlyWeather?.weathercode[i] ?? 0
                                Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherIcon ?? "")
                                    .foregroundColor(Color.white)
                            } // ska hämta data från viewmodel
                        }
                        HStack(spacing: 54){
                            ForEach(temperatures.prefix(20), id: \.self){ i in
                                Text("\(i)°")
                                    .foregroundColor(Color.white)
                            } // ska hämta data från viewmodel
                        }
                    }
                }
                .background(Color.gray.opacity(0))
                .cornerRadius(10)
                .padding(10)
                .offset(y: 20)
            }
        }.onAppear{
            weatherModel.getWeather()
        }
    }
}

struct TodaysWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysWeatherView()
    }
}
