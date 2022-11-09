//
//  TodaysWeatherView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

import SwiftUI

func gridCreator() -> [GridItem]{
    var columns: [GridItem] = []
    for _ in 0...2{
        columns.append(GridItem(.flexible()))
    }
    return columns
}


struct TodaysWeatherView: View {
    
    func gridCreator() -> [GridItem]{
        var columns: [GridItem] = []
        for _ in 0...20{
            columns.append(GridItem(.flexible()))
        }
        return columns
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
    @StateObject private var locationManager = LocationManager.shared
    var body: some View {
        VStack(){
            ZStack{
                /*Rectangle()
                 .fill(Color.white.opacity(0.2))
                 .frame(width: 365, height: 200)
                 .cornerRadius(15)*/
                ScrollView(.horizontal, showsIndicators: false) {
                    Grid{
                        GridRow{
                            ForEach(getAccurateIndexedTimeArray(), id: \.self) { time in
                                let desiredStringTwo = time.dropFirst(11).dropLast(3)
                                if(desiredStringTwo == getCurrentTime())
                                {
                                    Text("Now")
                                        .bold()
                                        .font(.system(size: 13))
                                        .foregroundColor(Color.white)
                                }
                                Text(desiredStringTwo)
                                    .bold()
                                    .font(.system(size: 13))
                                    .foregroundColor(Color.white) // add sunset and sunrise to distinct days
                            }
                        }
                        .padding()
                        GridRow{
                            let begin = getIndexForHour()
                            let end = getIndexForHour() + 20
                            ForEach(begin...end, id: \.self){ i in
                                let weatherCode: Int = weatherModel.hourlyWeather?.weathercode[i] ?? 0
                                Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherIcon ?? "")
                                    .foregroundColor(Color.white)
                            } // ska hämta data från viewmodel
                        }
                        .padding()
                        GridRow{
                            ForEach(getTemperatureForI(), id: \.self){ i in
                                Text("\(i)°")
                                    .foregroundColor(Color.white)
                            } // ska hämta data från viewmodel
                        }
                        .padding()
                    }
                }
                .background(
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                )
                //.background(Color.gray.opacity(0))
                .cornerRadius(15)
                .padding()
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
