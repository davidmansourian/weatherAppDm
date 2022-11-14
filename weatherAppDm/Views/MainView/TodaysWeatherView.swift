//
//  TodaysWeatherView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct TodaysWeatherView: View {
    @StateObject private var hourToday = WeatherViewModelHourly()
    @StateObject private var weatherModel = APILoader()
    @StateObject private var locationManager = LocationManager.shared
    var body: some View {
        VStack(){
            ZStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    Grid{
                        GridRow{
                            ForEach(hourToday.getAccurateIndexedTimeArray(), id: \.self) { time in
                                let desiredStringTwo = time.dropFirst(11).dropLast(3)
                                if(desiredStringTwo == hourToday.getCurrentTime())
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
                            let begin = hourToday.getIndexForHour()
                            let end = hourToday.getIndexForHour() + 20
                            ForEach(begin...end, id: \.self){ i in
                                let weatherCode: Int = hourToday.weatherCode?[i] ?? 0
                                Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherIcon ?? "")
                                    .renderingMode(.original)
                            } // ska hämta data från viewmodel
                        }
                        .padding()
                        GridRow{
                            ForEach(hourToday.getTemperatureForI(), id: \.self){ i in
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
                .shadow(radius: 3)
            }
        }
    }
}

struct TodaysWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysWeatherView()
    }
}
