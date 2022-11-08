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
        for temp in weatherModel.hourlyWeather?.temperature_2m.dropFirst(getIndexForHour()) ?? [0]{
            if temperatures.count < 20{
                let temperature: Int = Int(Float(temp))
                temperatures.append(temperature)
            }
            else { break }
            
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
        dateFormatter.dateFormat = "YY, MMM d, HH:mm"
        let dateString = dateFormatter.string(from: date).dropFirst(12).dropLast(3)
        return String(dateString)
    }
    
    func getIndexForHour() -> (Int){
        
        let times: [String] = getTimeForI()
        for (index, time) in times.enumerated(){
            let desiredStringTwo = time.dropFirst(11).dropLast(3)
            if desiredStringTwo == getCurrentTime(){
                return index
            }
        }
        return 0
    }
    
    func getAccurateIndexedTimeArray() -> [String]{
        let times: [String] = getTimeForI()
        var arr: [String] = []
        for time in times.dropFirst(getIndexForHour()){
            if arr.count < 20{
                arr.append(time)
            }
            else{ break }
        }
        return arr
    }

    @StateObject private var weatherModel = APILoader()
    @StateObject private var locationManager = LocationManager()
    var body: some View {
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
                        HStack(spacing: 22) {// Hello
                            ForEach(getAccurateIndexedTimeArray(), id: \.self) { time in
                                let desiredStringTwo = time.dropFirst(11).dropLast(3)
                                if(desiredStringTwo == getCurrentTime())
                                {
                                    Text("Now")
                                        .frame(width: 46, height: 30)
                                        .bold()
                                        .font(.system(size: 13))
                                        .foregroundColor(Color.white)
                                }
                                Text(desiredStringTwo)
                                    .frame(width: 46, height: 30)
                                    .bold()
                                    .font(.system(size: 13))
                                    .foregroundColor(Color.white) // add sunset and sunrise to distinct days
                            }
                        }
                        HStack(spacing: 49.2){
                            let begin = getIndexForHour()
                            let end = getIndexForHour() + 19
                            ForEach(begin...end, id: \.self){ i in
                                let weatherCode: Int = weatherModel.hourlyWeather?.weathercode[i] ?? 0
                                Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherIcon ?? "")
                                    .foregroundColor(Color.white)
                            } // ska hämta data från viewmodel
                        }
                        HStack(spacing: 53.8){
                            ForEach(getTemperatureForI(), id: \.self){ i in
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
        }.onAppear(){
            weatherModel.getWeather()

        }
    }
}

struct TodaysWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysWeatherView()
    }
}
