//
//  TodaysWeatherTextView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct TodaysWeatherTextView: View {
    @StateObject private var weatherModel = APILoader()
    var body: some View {
        let temperature: Int = Int(Float(weatherModel.weather?.temperature ?? 0))
        VStack{
            Text("Jönköping") // data ska senare hämtas från viewModel
                .font(Font.title)
                .bold()
                .foregroundColor(Color.white)
            Text("\(temperature)") // data ska senare hämtas från viewModel
                .font(.system(size: 70))
                .foregroundColor(Color.white)
            Text("Mostly Cloudy") // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
            Text("H:10 L:5") // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
        }
        .onAppear{
            weatherModel.getWeather()
        }
    }
}
struct TodaysWeatherTextView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysWeatherTextView()
    }
}
