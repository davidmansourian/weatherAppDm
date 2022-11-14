//
//  DailyWeatherResultView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-11.
//

import SwiftUI

struct DailyWeatherResultView: View {
    @ObservedObject var weatherModel = SubWeatherModdel()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Grid{
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Text(weatherModel.subDailyWeatherVM?.getDayName()[day] ?? "")
                            .foregroundColor(Color.white)
                    }
                }
                .padding()
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherModel.subDailyWeatherVM?.getDailyImgString()[day] ?? 0]?.weatherIcon ?? "")
                            .renderingMode(.original)
                    }
                }
                .padding()
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Text(weatherModel.subDailyWeatherVM?.getDailyAvgTemp()[day] ?? "")
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
