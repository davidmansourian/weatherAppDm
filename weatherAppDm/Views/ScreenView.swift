//
//  ScreenView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct ScreenView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors:[.orange,.blue]), startPoint: UnitPoint(x:1.9, y: -0.05), endPoint: UnitPoint(x: 0.4, y: 1))
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical){
                VStack(spacing: 15) {
                    Spacer()
                        Text("Jönköping") // data ska senare hämtas från viewModel
                            .font(Font.title)
                            .bold()
                            .foregroundColor(Color.white)
                        Text("10°") // data ska senare hämtas från viewModel
                            .font(.system(size: 70))
                            .foregroundColor(Color.white)
                        Text("Mostly Cloudy") // data ska senare hämtas från viewModel
                            .bold()
                            .foregroundColor(Color.white)
                        Text("H:11 L:6") // data ska senare hämtas från viewModel
                            .bold()
                            .foregroundColor(Color.white)
                    TodaysWeatherView()
                    ForecastView()
                }
            }
        }
        .toolbar{
            
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
    }
}
