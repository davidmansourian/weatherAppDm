//
//  ForecastView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var weatherViewModelDaily: WeatherViewModelDaily
    //@StateObject private var locationManager = LocationManager.shared

    let columns = [GridItem(.flexible()),
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
                        Text(weatherViewModelDaily.getDayName()[day])
                            .foregroundColor(Color.white)
                        Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherViewModelDaily.getDailyImgString()[day]]?.weatherIcon ?? "")
                            .renderingMode(.original)
                            .foregroundColor(Color.white)
                        Text(weatherViewModelDaily.getDailyAvgTemp()[day])
                            .foregroundColor(Color.white)
                        
//                        Divider() LazyVGrid divider multiple column foreach
                    }
                }
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(weatherViewModelDaily: WeatherViewModelDaily(weatherModel: MainWeatherAppModel()))
    }
}
