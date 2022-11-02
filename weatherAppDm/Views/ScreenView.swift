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
//                LinearGradient(gradient: Gradient(colors:[.orange,.blue]), startPoint: UnitPoint(x:1.9, y: -0.05), endPoint: UnitPoint(x: 0.4, y: 1))
//                    .edgesIgnoringSafeArea(.all)
                LinearGradient(gradient: Gradient(colors:[.yellow,.orange,.blue]), startPoint: .topTrailing, endPoint: .bottomLeading) // Change color depending on time of day and weather
                    .edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .center, spacing: 15) {
                        TodaysWeatherTextView()
                        TodaysWeatherView()
                        ForecastView()
                    }
                }
                .padding(.top, 1)
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        NavigationLink(destination: SearchView()){
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.black)
                                .padding(10)
                                .background(Color.white.opacity(0.4))
                                .clipShape(Circle())
                        }
                    }
                    ToolbarItemGroup(placement: .navigationBarLeading){
                        NavigationLink(destination:{}){
                            Image(systemName: "heart")
                                .foregroundColor(Color.black)
                                .padding(10)
                                .background(Color.white.opacity(0.4))
                                .clipShape(Circle())
                        }
                    }
                    ToolbarItemGroup(placement: .principal){
                        SearchView()
                    } // if pressed then show bar with results and blur background view
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
