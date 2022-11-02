//
//  ScreenView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct ScreenView: View {
    @State public var showSearchBar = false
    var body: some View {
        NavigationStack{
            ZStack{
//                LinearGradient(gradient: Gradient(colors:[.orange,.blue]), startPoint: UnitPoint(x:1.9, y: -0.05), endPoint: UnitPoint(x: 0.4, y: 1))
//                    .edgesIgnoringSafeArea(.all)
                LinearGradient(gradient: Gradient(colors:[.yellow,.blue,.blue]), startPoint: .topTrailing, endPoint: .bottomLeading) // Change color depending on time of day and weather
                    .edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                        VStack(alignment: .center, spacing: 15) {
                            TodaysWeatherTextView()
                            TodaysWeatherView()
                            ForecastView()
                    }
                }
                .onTapGesture {
                    if showSearchBar{
                        withAnimation(.linear(duration: 0.2)){
                            showSearchBar.toggle()
                        }
                        
                    }
                }
                .blur(radius: showSearchBar ? 5 : 0)
                .padding(.top, 1)
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button {
                            withAnimation(.linear(duration: 0.6)){
                                showSearchBar.toggle()
                            }
                        } label: {
                            if !showSearchBar{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.black)
                                    .padding(10)
                                    .background(Color.white.opacity(0.4))
                                    .clipShape(Circle())
                            }
                        }
                    }
                    if !showSearchBar{
                        ToolbarItemGroup(placement: .navigationBarLeading){
                            NavigationLink(destination:{}){
                                Image(systemName: "heart")
                                    .foregroundColor(Color.black)
                                    .padding(10)
                                    .background(Color.white.opacity(0.4))
                                    .clipShape(Circle())
                            }
                        }
                    }
                    ToolbarItemGroup(placement: .principal){
                        if showSearchBar{
                            SearchView()
                        }
                    } // if pressed then show bar with results and blur background view
                }
            }
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
    }
}

