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
    @StateObject var subResultDaily = WeatherSubViewModelDaily()
    @StateObject var subResultCurrent = WeatherViewSubModelCurrent()
    @ObservedObject var searchResult = SearchResultViewModel.shared
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 650
    @State private var isLiked: Bool = false
    @State private var epsilon = 0.000001
    
    let minHeight: CGFloat = 600
    let maxHeight: CGFloat = 680
    var body: some View {
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
    
    var mainView: some View{
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
                            Text(subResultCurrent.cityName ?? "-") // data ska senare hämtas från viewModel
                                .font(Font.title)
                                .foregroundColor(Color.white)
                            Image(systemName: TranslatedWeathercodes().weatherCodeProperties[subResultCurrent.weatherCode ?? 0]?.weatherIcon ?? "")
                                .renderingMode(.original)
                                .font(.system(size: 60))
                            Text("\(subResultCurrent.temperature ?? 0)")
                                .font(Font.title)
                                .foregroundColor(Color.white)
                            Text(TranslatedWeathercodes().weatherCodeProperties[subResultCurrent.weatherCode ?? 0]?.weatherDescription ?? "")
                                .foregroundColor(Color.white)
                            DailyWeatherResultView()
                        }
                        .offset(y: -60)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .onAppear{
            print("chosen location in popup view: ", self.searchResult.chosenLocation)
            
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
    
    
    
    
    
    
    
    
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
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
    
    // https://stackoverflow.com/questions/20794757/check-if-name-attribute-already-exists-in-coredata
    // https://stackoverflow.com/questions/57741929/swiftui-with-core-data-fetch-request-with-predicate-crashes
     func itemExists(latitude: Double, longitude: Double) -> Bool {
        let fetchRequest : NSFetchRequest<SavedWeather> = SavedWeather.fetchRequest()
        let predicate = NSPredicate(format: "latitude > %f AND latitude < %f AND longitude > %f AND longitude < %f", latitude - epsilon, latitude + epsilon, longitude - epsilon, longitude + epsilon)
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
    
    
    func addToData(latitude: Double, longitude: Double){
        print(itemExists(latitude: latitude, longitude: longitude))
        if !itemExists(latitude: latitude, longitude: longitude){
            print("NU ÄR JAG I BÖRJAN AV KNAPPEN")
            let weatherPage = SavedWeather(context: moc)
            weatherPage.id = UUID()
            print("weatherPageID: ", weatherPage.id ?? 0)
            weatherPage.latitude = searchResult.chosenLocation.latitude
            print("weatherPageLatitude: ", weatherPage.latitude)
            weatherPage.longitude = searchResult.chosenLocation.longitude
            print("weatherPageLongitude: ", weatherPage.latitude)
            weatherPage.cityName = subResultCurrent.cityName
            print("NU SPARAR JAG")
            try? moc.save()
            print("NU HAR JAG SPARAT")
        }
    }
    
    //    var isLiked: Bool = itemExists(latitude: searchResult.chosenLocation.latitude, longitude: searchResult.chosenLocation.longitude)
}

struct WeatherResultView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherResultView(showResult: .constant(true))
    }
    
}


extension WeatherResultView{
    var likeButtonView: some View{
        if !itemExists(latitude: searchResult.chosenLocation.latitude, longitude: searchResult.chosenLocation.longitude){
           return AnyView(Button{
                addToData(latitude: searchResult.chosenLocation.latitude, longitude: searchResult.chosenLocation.longitude)
                print ("sparad")
            } label: {
                Image(systemName: "heart")
                    .foregroundColor(Color.black)
                    .padding(10)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            })
        }
        else{
            return AnyView(Button{
                print ("finns redan")
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
                    .padding(10)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            })
        }
    }
}


//    if itemExists(latitude: searchResult.chosenLocation.latitude, longitude: searchResult.chosenLocation.longitude){
//        Button{
//            withAnimation(.easeInOut(duration: 0.1)){
//                if !itemExists(latitude: searchResult.chosenLocation.latitude, longitude: searchResult.chosenLocation.longitude){
//                    addToData(latitude: searchResult.chosenLocation.latitude, longitude: searchResult.chosenLocation.longitude)
//                }
//            }
//        } label: {
//            if itemExists(latitude: searchResult.chosenLocation.latitude, longitude: searchResult.chosenLocation.longitude){
//                Image(systemName: "heart.fill")
//                    .foregroundColor(Color.red)
//                    .padding(10)
//                    .background(Color.white.opacity(0.4))
//                    .clipShape(Circle())
//            }
//            else{
//                Image(systemName: "heart")
//                    .foregroundColor(Color.black)
//                    .padding(10)
//                    .background(Color.white.opacity(0.4))
//                    .clipShape(Circle())
//            }
//        }
//    }
//}
