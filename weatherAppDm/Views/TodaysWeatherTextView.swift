//
//  TodaysWeatherTextView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct TodaysWeatherTextView: View {
    @ObservedObject var viewModelCurrent: WeatherViewModelCurrent
    var body: some View {
        VStack{
            Text(viewModelCurrent.city) // data ska senare hämtas från viewModel
                .font(Font.title)
                .bold()
                .foregroundColor(Color.white)
            Text(viewModelCurrent.temperature) // data ska senare hämtas från viewModel
                .font(.system(size: 70))
                .foregroundColor(Color.white)
            Text("Mostly Cloudy") // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
            Text("H:\(viewModelCurrent.temperatureHigh) L:\(viewModelCurrent.temperatureLow)") // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
        }.onAppear(perform: viewModelCurrent.refresh)
    }
}

struct TodaysWeatherTextView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysWeatherTextView(viewModelCurrent: WeatherViewModelCurrent(weatherLocationHandler: WeatherLocationHandler()))
    }
}
