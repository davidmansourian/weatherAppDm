//
//  WeatherResultView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-10.
//

import SwiftUI
import CoreLocation
import CoreData


// shared class solution found here https://stackoverflow.com/questions/68675389/modify-published-variable-from-another-class-that-is-not-declared-in-swiftui
//modal transition tutorial found here https://www.youtube.com/watch?v=I1fsl1wvsjY


struct WeatherResultView: View {
    @FetchRequest(sortDescriptors: []) var weatherPages: FetchedResults<SavedWeather>
    var moc = PersistenceController.shared.container.viewContext
    @Binding var showResult: Bool
    @Binding var chosenResult: CLLocationCoordinate2D
    @ObservedObject var weatherModel = SubWeatherModdel()
    //@ObservedObject var searchResult = SearchResultViewModel.shared
   // @StateObject private var weatherModel = SubWeatherModdel()
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 650
    @State private var isLiked: Bool = false
    
    let minHeight: CGFloat = 600
    let maxHeight: CGFloat = 680
    var body: some View {
        designedView
    }
    var mainView: some View{
        designedMainView
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
       theGesture
    }
    
    //    var isLiked: Bool = itemExists(latitude: searchResult.chosenLocation.latitude, longitude: searchResult.chosenLocation.longitude)
}

struct WeatherResultView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherResultView(showResult: .constant(true), chosenResult: .constant(CLLocationCoordinate2D()))
    }
    
}





extension WeatherResultView{
    var theGesture: some Gesture{
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging{
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount / 6
                }
                else{
                    curHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded{ val in
                prevDragTranslation = .zero
                isDragging = false
                if curHeight > maxHeight{
                    curHeight = maxHeight
                }
                else if curHeight < maxHeight{
                    curHeight = minHeight
                }
                //                else if curHeight <= minHeight{
                //                    showResult = false
                //                }
                
            }
    }
}

extension WeatherResultView{
    @ViewBuilder
    var designedView: some View{
        ZStack(alignment: .bottom){
            if showResult{
                Color.black
                    .opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture{
                        showResult = false
                    }
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.linear(duration: 1), value: isDragging)
    }
    
    @ViewBuilder var designedMainView: some View{
        VStack{
            ZStack{
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            
            ZStack{
                VStack{
                    if showResult{
                        likeButtonView
                           .offset(x: -160, y: -90)
                           .padding()
                        VStack{
                            Text(weatherModel.subCurrentWeatherVM?.cityName ?? "-") // data ska senare hämtas från viewModel
                                .font(Font.title)
                                .foregroundColor(Color.white)
                            Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherModel.subCurrentWeatherVM?.weatherCode ?? 0]?.weatherIcon ?? "")
                                .renderingMode(.original)
                                .font(.system(size: 60))
                            Text("\(weatherModel.subCurrentWeatherVM?.temperature ?? 0)")
                                .font(Font.title)
                                .foregroundColor(Color.white)
                            Text(TranslatedWeathercodes().weatherCodeProperties[weatherModel.subCurrentWeatherVM?.weatherCode ?? 0]?.weatherDescription ?? "")
                                .foregroundColor(Color.white)
                            dailyWeatherForecast
                        }
                        .offset(y: -60)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .onAppear{
            weatherModel.subWeatherService.getWeather(latitude: self.chosenResult.latitude, longitude: self.chosenResult.longitude)
            weatherModel.subWeatherService.getCityName(theLocation: CLLocation(latitude: self.chosenResult.latitude, longitude: self.chosenResult.longitude))
            
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack{
                RoundedRectangle(cornerRadius: 25.0)
                Rectangle()
                    .frame(height: curHeight)
                    .cornerRadius(25)
            }
                .onTapGesture {
                    showResult = false
                }
                .foregroundColor(Color.black.opacity(0.8))
                .background(
                    LinearGradient(gradient: Gradient(colors: [.yellow, .blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .cornerRadius(25)
                )
                .opacity(0.5)
        )
        .animation(isDragging ? nil : .easeInOut(duration: 0.45), value: isDragging)
    }
}


extension WeatherResultView{
    var dailyWeatherForecast: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Grid{
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Text(weatherModel.subDailyWeatherVM?.getDayName()[day] ?? "")
                            .foregroundColor(Color.white)
                    }
                }
                .padding()
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Image(systemName: TranslatedWeathercodes().weatherCodeProperties[weatherModel.subDailyWeatherVM?.getDailyImgString()[day] ?? 0]?.weatherIcon ?? "")
                            .renderingMode(.original)
                    }
                }
                .padding()
                GridRow{
                    ForEach(0...6, id: \.self){ day in
                        Text(weatherModel.subDailyWeatherVM?.getDailyAvgTemp()[day] ?? "")
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
}


extension WeatherResultView{
    var likeButtonView: some View{
        if !itemExists(latitude: chosenResult.latitude, longitude: chosenResult.longitude){
           return AnyView(Button{
                addToData(latitude: chosenResult.latitude, longitude: chosenResult.longitude)
                print ("sparad")
            } label: {
                Image(systemName: "heart")
                    .foregroundColor(Color.black)
                    .padding(10)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            })
        }
        else if itemExists(latitude: chosenResult.latitude, longitude: chosenResult.longitude){
            return AnyView(Button{
                deleteItem()
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
                    .padding(10)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            })
        }
        else{
            return AnyView(Button{
                print ("finns redan")
            } label: {
                Image(systemName: "heart")
                    .foregroundColor(Color.black)
                    .padding(10)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            })
        }
    }
    
}

extension WeatherResultView{
    // https://stackoverflow.com/questions/20794757/check-if-name-attribute-already-exists-in-coredata
    // https://stackoverflow.com/questions/57741929/swiftui-with-core-data-fetch-request-with-predicate-crashes
    // https://stackoverflow.com/questions/19713261/how-would-you-make-a-predicate-in-coredata-to-search-for-a-float-within-a-tolera
    func itemExists(latitude: Double, longitude: Double) -> Bool {
        let fetchRequest : NSFetchRequest<SavedWeather> = SavedWeather.fetchRequest()
        print("LATITUDE: ", latitude, "LONGITUDE: ", longitude)
        let predicate = NSPredicate(format: "abs(latitude - %f) < 0.00001 AND abs(longitude - %f) < 0.00001", latitude, longitude)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        do{
            let count = try moc.count(for: fetchRequest)
            
            if count == 0{
                return false
            }
            else{
                return true
            }
        } catch let error as NSError{
            print("Could not fetch \(error) \(error.userInfo)")
        }
        return true
    }
    
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
    
    func addToData(latitude: Double, longitude: Double){
        print(itemExists(latitude: latitude, longitude: longitude))
        if !itemExists(latitude: latitude, longitude: longitude){
            let weatherPage = SavedWeather(context: moc)
            weatherPage.id = UUID()
            weatherPage.latitude = chosenResult.latitude
            weatherPage.longitude = chosenResult.longitude
            weatherPage.cityName = weatherModel.subCurrentWeatherVM?.cityName
            try? moc.save()
        }
    }
}

