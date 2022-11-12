//
//  DailyWeatherResultView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-11.
//

import SwiftUI

struct DailyWeatherResultView: View {
    @StateObject var subResultDaily = WeatherSubViewModelDaily()
    @StateObject var subResultCurrent = WeatherViewSubModelCurrent()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Grid{
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Text(subResultDaily.getDayName()[day])
                            .foregroundColor(Color.white)
                    }
                }
                .padding()
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Image(systemName: TranslatedWeathercodes().weatherCodeProperties[subResultDaily.getDailyImgString()[day]]?.weatherIcon ?? "")
                            .renderingMode(.original)
                    }
                }
                .padding()
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Text(subResultDaily.getDailyAvgTemp()[day])
                            .foregroundColor(Color.white)
                    }
                }
                .padding()
            }
        }
        .background(
            Rectangle()
                .fill(Color.white.opacity(0.08))
        )
        //.background(Color.gray.opacity(0))
        .cornerRadius(15)
        .padding()
        .shadow(radius: 3)
    }
}

struct DailyWeatherResultView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherResultView()
    }
}
