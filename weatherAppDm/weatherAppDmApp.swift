//
//  weatherAppDmApp.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

@main
struct weatherAppDmApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherLocationHandler = WeatherLocationHandler()
            let viewModelCurrent = WeatherViewModelCurrent(weatherLocationHandler: weatherLocationHandler)
            ScreenView(viewModelCurrent: viewModelCurrent)
        }
    }
}
