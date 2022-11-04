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
    
    @StateObject private var weatherModel = APILoader()
    var times = ["Now", "7 am", "8 am", "9 am", "10 am", "11 am", "12 am", "13 am", "14 am", "15 am"]
    var grads = ["10"]
    var body: some View {
        var temperatures: [Int] = getTemperatureForI()
        
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
                    Text("Wheather info text from ViewModel. Bla Bla Bla fasdf")
                        .offset(y: -70)
                        .foregroundColor(Color.white)
                        .font(Font.footnote)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(spacing: 15){
                        HStack(spacing: 30) {
//                            ForEach(times, id: \.self) { time in
//                                Text(time)
//                                    .frame(width: 46, height: 30)
//                                    .bold()
//                                    .font(.system(size: 13))
//                                    .foregroundColor(Color.white)
//                            }
                            
//                            ForEach(theDate, id: \.self){ time in
//                                Text((time?[12] ?? "") + (time?[13] ?? ""))
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
