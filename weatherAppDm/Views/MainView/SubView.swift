import SwiftUI
import CoreLocation

struct SubView: View {
    
    func assignLatLong(receivedIndex: Int) -> some View{
        return Text("hej")
    }
    
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var moc = PersistenceController.shared.container.viewContext
    @StateObject var weatherModel = SubWeatherModdel()
    @FetchRequest(sortDescriptors: []) var weatherPages: FetchedResults<SavedWeather>
    @State var theLatitude: Double?
    @State var theLongitude: Double?
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors:[.yellow,.blue,.blue]), startPoint: .topTrailing, endPoint: .bottomLeading) // Change color depending on time of day and weather
            //TranslatedWeathercodes().backGroundForWeatherCode[0]
                .edgesIgnoringSafeArea(.all)
            TabView{
                ForEach(0..<weatherPages.count, id: \.self){ page in
                    ZStack{
                        ScrollView(.vertical){
                            makeCurrentWeatherView(getIndex: page)
                            //makeDailyWeatherView(getIndex: page)
                        }
                    }
                    /*.onAppear(){
                     for page in weatherPages{
                     weatherModel.subWeatherService.getWeather(latitude: page.latitude, longitude: page.longitude)
                     weatherModel.subWeatherService.getCityName(theLocation: CLLocation(latitude: page.latitude, longitude: page.longitude))
                     }
                     }*/
                    .refreshable {
                        //
                    }
                    //            .tabViewStyle(.page(indexDisplayMode: .never))
                    //            .indexViewStyle(.page(backgroundDisplayMode: .never))
                }
            }
            //.cornerRadius(10)
            .transition(transition)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button {
                    withAnimation(.linear(duration: 0.2)){
                        deleteItem()
                    }
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color.red)
                        .padding(10)
                        .background(Color.white.opacity(0.4))
                        .clipShape(Circle())
                }
            }
        }
    }
}


struct SubView_Previews: PreviewProvider {
    static var previews: some View {
        SubView()
    }
}





extension SubView{
    
    func deleteItem(){
        print("HI IM HERE")
        for page in weatherPages{
            print("OFFSET: ", offset)
            print(page)
            if page.cityName == weatherModel.subCurrentWeatherVM?.cityName{
                moc.delete(page)
            }
        }
        try? moc.save()
   }
    
    
    @ViewBuilder func makeCurrentWeatherView(getIndex: Int) -> some View{
        VStack{
            VStack{
                Text(weatherModel.subCurrentWeatherVM?.cityName ?? "-")
                    .font(Font.title)
                    .bold()
                    .foregroundColor(Color.white)
                Text("\(weatherModel.subCurrentWeatherVM?.temperature ?? 0)°")
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                Text(TranslatedWeathercodes().weatherCodeProperties[weatherModel.subCurrentWeatherVM?.weatherCode ?? 0]?.weatherDescription ?? "") // data ska senare hämtas från viewModel
                    .bold()
                    .foregroundColor(Color.white)
                Text("H:\(Int(Float(weatherModel.subDailyWeatherVM?.maxTemp?.first ?? 0)))°" + " " + "L:\(Int(Float(weatherModel.subDailyWeatherVM?.minTemp?.first ?? 0)))°") // data ska senare hämtas från viewModel
                    .bold()
                    .foregroundColor(Color.white)
            }
            VStack(){
                ZStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        Grid{
                            GridRow{
                                ForEach(weatherModel.subHourlyWeatherVM?.getAccurateIndexedTimeArray() ?? [""], id: \.self) { time in
                                    let desiredStringTwo = time.dropFirst(11).dropLast(3)
                                    if(desiredStringTwo == weatherModel.subHourlyWeatherVM?.getCurrentTime() ?? "")
                                    {
                                        Text("Now")
                                            .bold()
                                            .font(.system(size: 13))
                                            .foregroundColor(Color.white)
                                    }
                                    Text(desiredStringTwo)
                                        .bold()
                                        .font(.system(size: 13))
                                        .foregroundColor(Color.white) // add sunset and sunrise to distinct days
                                }
                            }
                            .padding()
                            GridRow{
                                let begin = weatherModel.subHourlyWeatherVM?.getIndexForHour()
                                let end = (weatherModel.subHourlyWeatherVM?.getIndexForHour() ?? 0) + 20
                                ForEach((begin ?? 0)...end, id: \.self){ i in
                                    let weatherCode: Int = weatherModel.subHourlyWeatherVM?.weatherCode?[i] ?? 0
                                    Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherCode]?.weatherIcon ?? "")
                                        .renderingMode(.original)
                                } // ska hämta data från viewmodel
                            }
                            .padding()
                            GridRow{
                                ForEach(weatherModel.subHourlyWeatherVM?.getTemperatureForI() ?? [0], id: \.self){ i in
                                    Text("\(i)°")
                                        .foregroundColor(Color.white)
                                } // ska hämta data från viewmodel
                            }
                            .padding()
                        }
                    }
                    .background(
                        Rectangle()
                            .fill(Color.white.opacity(0.2))
                    )
                    //.background(Color.gray.opacity(0))
                    .cornerRadius(15)
                    .padding()
                    .shadow(radius: 3)
                }
            }
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
                        ForEach(0...6, id: \.self){day in
                            Text(weatherModel.subDailyWeatherVM?.getDayName()[day] ?? "")
                                .foregroundColor(Color.white)
                            Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherModel.subDailyWeatherVM?.getDailyImgString()[day] ?? 0]?.weatherIcon ?? "")
                                .renderingMode(.original)
                                .foregroundColor(Color.white)
                            Text(weatherModel.subDailyWeatherVM?.getDailyAvgTemp()[day] ?? "" + "°")
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
        }
        .onAppear(){
            weatherModel.subWeatherService.getWeather(latitude: weatherPages[getIndex].latitude, longitude: weatherPages[getIndex].longitude)
            weatherModel.subWeatherService.getCityName(theLocation: CLLocation(latitude: weatherPages[getIndex].latitude, longitude: weatherPages[getIndex].longitude))
        }
    }
}

/*private extension SubView{
 @ViewBuilder func makeDailyWeatherView(getIndex: Int) -> some View{
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
 ForEach(0...6, id: \.self){day in
 Text(weatherModel.subDailyWeatherVM?.getDayName()[day] ?? "")
 .foregroundColor(Color.white)
 Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherModel.subDailyWeatherVM?.getDailyImgString()[day] ?? 0]?.weatherIcon ?? "")
 .renderingMode(.original)
 .foregroundColor(Color.white)
 Text(weatherModel.subDailyWeatherVM?.getDailyAvgTemp()[day] ?? "")
 .foregroundColor(Color.white)
 }
 }
 }
 }
 
 //                        Divider() LazyVGrid divider multiple column foreach
 }
 }*/





