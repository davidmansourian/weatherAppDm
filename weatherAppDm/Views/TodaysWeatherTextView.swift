//
//  TodaysWeatherTextView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct TodaysWeatherTextView: View {
    var body: some View {
        Text("Jönköping") // data ska senare hämtas från viewModel
            .font(Font.title)
            .bold()
            .foregroundColor(Color.white)
        Text("10°") // data ska senare hämtas från viewModel
            .font(.system(size: 70))
            .foregroundColor(Color.white)
        Text("Mostly Cloudy") // data ska senare hämtas från viewModel
            .bold()
            .foregroundColor(Color.white)
        Text("H:11 L:6") // data ska senare hämtas från viewModel
            .bold()
            .foregroundColor(Color.white)
    }
}

struct TodaysWeatherTextView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysWeatherTextView()
    }
}
