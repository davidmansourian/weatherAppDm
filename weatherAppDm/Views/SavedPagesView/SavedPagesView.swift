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
    @StateObject var weeklys: WeatherSubViewModelDaily
    @StateObject var todays: SubViewModelCurrent
    @StateObject var codeTranslator = TranslatedWeathercodes()
    @StateObject var weatherService = APILoader()
    @FetchRequest(sortDescriptors: []) var weatherPages: FetchedResults<SavedWeather>
    @State private var isLiked = false
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
                            VStack(alignment: .center, spacing: 15) {
                                Text(weatherPages[page].cityName ?? "")
                                Text("\(weatherPages[page].latitude)")
                                Text("\(weatherPages[page].longitude)")
                            }
                        }
                    }
                    .onAppear(){
                    }
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
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            
        }
    }
}


struct SavedPagesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedPagesView(weeklys: WeatherSubViewModelDaily(weatherModel: SubWeatherModdel()), todays: SubViewModelCurrent(weatherModel: SubWeatherModdel()))
    }
}


//    .toolbar{
//        ToolbarItemGroup(placement: .navigationBarTrailing){
//            Button {
//                withAnimation(.linear(duration: 0.2)){
//                }
//            } label: {
//                Image(systemName: "magnifyingglass")
//                    .foregroundColor(Color.black)
//                    .padding(10)
//                    .background(Color.white.opacity(0.4))
//                    .clipShape(Circle())
//            }
//        }
//    }
