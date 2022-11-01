//
//  ScreenView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct ScreenView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors:[.orange,.blue]), startPoint: UnitPoint(x:1.9, y: -0.05), endPoint: UnitPoint(x: 0.4, y: 1))
                    .edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .center, spacing: 15) {
                        Spacer()
                        TodaysWeatherTextView()
                        TodaysWeatherView()
                        ForecastView()
                    }
                }
                .padding(.top, 1)
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        NavigationLink(destination:{}){
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.white)
                        }
                    }
                    ToolbarItemGroup(placement: .navigationBarLeading){
                        NavigationLink(destination:{}){
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(Color.white)
                        }
                    }
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
