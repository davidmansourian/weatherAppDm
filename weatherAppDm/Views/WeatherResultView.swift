//
//  WeatherResultView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-10.
//

import SwiftUI

struct WeatherResultView: View {
    @Binding var showResult: Bool
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 650
    let minHeight: CGFloat = 650
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
                    Text("Tjenare mannen")
                    Text("Hej")
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack{
                RoundedRectangle(cornerRadius: 25.0)
                Rectangle()
                    .frame(height: curHeight)
            }
                .foregroundColor(.white.opacity(0.3))
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
                
            }
    }
}

struct WeatherResultView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherResultView(showResult: .constant(true))
    }
}
