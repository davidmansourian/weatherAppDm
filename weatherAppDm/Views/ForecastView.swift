//
//  ForecastView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct Forecast: Hashable{
    var id: Int
    var temperature: String
    var image: String
    var day: String
    
}

struct ForecastView: View {
    // viewModel should send data to here
    @State var days = [Forecast(id: 0, temperature: "10°", image: "cloud", day: "Today"),
                       Forecast(id: 1, temperature: "10°", image: "cloud", day: "Tue"),
                       Forecast(id: 2, temperature: "10°", image: "cloud", day: "Wed"),
                       Forecast(id: 3, temperature: "10°", image: "cloud", day: "Thu"),
                       Forecast(id: 4, temperature: "10°", image: "cloud", day: "Fri"),
                       Forecast(id: 5, temperature: "10°", image: "cloud", day: "Sat"),
                       Forecast(id: 6, temperature: "10°", image: "cloud", day: "Sun"),
                       Forecast(id: 7, temperature: "10°", image: "cloud", day: "Mon")]
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    let rows = [GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
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
                    ForEach(days, id: \.self){ day in
                        Text(day.day)
                            .foregroundColor(Color.white)
                        Image(systemName: day.image)
                            .foregroundColor(Color.white)
                        Text(day.temperature)
                            .foregroundColor(Color.white)
                        //Divider() LazyVGrid divider multiple column foreach 
                    }
                }
            }
        }
    }
}

//Text("hej hej hej hej hej hej hej hej hej hej hej hej hej hej")
struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}


//                HStack {
//                    VStack(alignment: .leading ,spacing: 15){
//                        ForEach(days, id: \.self){ day in
//                            HStack(spacing: 100){
//                                Text(day)
//                                    .foregroundColor(Color.white)
//                                Image(systemName: "cloud")
//                                    .foregroundColor(Color.white)
//                                Text("10°")
//                                    .foregroundColor(Color.white)
//                            }
//                            Divider()
//                        }
//                        .offset(x: 23, y: 1)
//                    }
//                }
