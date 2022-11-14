//
//  SavedPagesView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-13.
//

import SwiftUI

struct SavedPagesView: View {
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]

    var moc = PersistenceController.shared.container.viewContext
    @StateObject var weeklys = WeatherSubViewModelDaily()
    @StateObject var todays = WeatherViewSubModelCurrent()
    @StateObject var codeTranslator = TranslatedWeathercodes()
    @FetchRequest(sortDescriptors: []) var weatherPages: FetchedResults<SavedWeather>
    @State private var isLiked = false

    var body: some View {
        NavigationStack{
                    ZStack{
                        LinearGradient(gradient: Gradient(colors:[.yellow,.blue,.blue]), startPoint: .topTrailing, endPoint: .bottomLeading) // Change color depending on time of day and weather
                        //TranslatedWeathercodes().backGroundForWeatherCode[0]
                            .edgesIgnoringSafeArea(.all)
                        ScrollView(.vertical){
                            VStack(alignment: .center, spacing: 15) {
                                currentForecast
                                hourlyForecast
                                dailyForecast
                            }
                        }
                    }
                    .onAppear(){
                        //
                    }
                    .refreshable {
                        //
                    }
//            .tabViewStyle(.page)
//            .indexViewStyle(.page(backgroundDisplayMode: .never))
        }
    }
}

struct SavedPagesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedPagesView()
    }
}


extension SavedPagesView{
    var currentForecast: some View{
        VStack{
            Text(todays.cityName ?? "") // data ska senare hämtas från viewModel
                .font(Font.title)
                .bold()
                .foregroundColor(Color.white)
            Text("\(todays.temperature ?? 0)°") // data ska senare hämtas från viewModel
                .font(.system(size: 50))
                .foregroundColor(Color.white)
            Text(codeTranslator.weatherCodeProperties[todays.weatherCode ?? 0]?.weatherDescription ?? "") // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
            Text("H:\(Int(Float(todays.maxTemp?.first ?? 0)))°" + " " + "L:\(Int(Float(todays.minTemp?.first ?? 0)))°") // data ska senare hämtas från viewModel
                .bold()
                .foregroundColor(Color.white)
        }

    }


    var hourlyForecast: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Grid{
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Text(weeklys.getDayName()[day])
                            .foregroundColor(Color.white)
                    }
                }
                .padding()
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weeklys.getDailyImgString()[day]]?.weatherIcon ?? "")
                            .renderingMode(.original)
                    }
                }
                .padding()
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Text(weeklys.getDailyAvgTemp()[day])
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



    var dailyForecast: some View {
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
                    ForEach(0...6, id: \.self){ day in
                        Text(weeklys.getDayName()[day])
                            .foregroundColor(Color.white)
                        Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weeklys.getDailyImgString()[day]]?.weatherIcon ?? "")
                            .renderingMode(.original)
                            .foregroundColor(Color.white)
                        Text(weeklys.getDailyAvgTemp()[day])
                            .foregroundColor(Color.white)

//                        Divider() LazyVGrid divider multiple column foreach
                    }
                }
            }
        }
    }


}
