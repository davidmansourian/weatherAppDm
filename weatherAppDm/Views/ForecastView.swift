//
//  ForecastView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct ForecastView: View {
    // viewModel should send data to here
    var days = ["Today", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"]
    
    var body: some View {
        VStack(spacing: 10){
            ZStack{
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 365, height: 500)
                    .cornerRadius(15)
                Divider()
                    .frame(width: 365)
                    .offset(y: -210)
                HStack {
                    Text("7 Day Forecast")
                        .offset(y: -230)
                        .foregroundColor(Color.white)
                        .font(Font.footnote)
                }
                HStack {
                    VStack(alignment: .leading ,spacing: 15){
                        ForEach(days, id: \.self){ day in
                            HStack(spacing: 100){
                                Text(day)
                                    .foregroundColor(Color.white)
                                Image(systemName: "cloud")
                                    .foregroundColor(Color.white)
                                Text("10°")
                                    .foregroundColor(Color.white)
                            }
                            Divider()
                        }
                        .offset(x: 23, y: 1)
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
