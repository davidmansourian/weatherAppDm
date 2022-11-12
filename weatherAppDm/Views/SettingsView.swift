//
//  SettingsView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-12.
//

import SwiftUI

struct SettingsView: View {
    @State var rainNotification: Bool = false
    @State var forecastNotification: Bool = false
    var body: some View {
        NavigationStack{
            ZStack {
                Form{
                    Section(header: Text("Notification Settings")){
                        Toggle("Notify me if it is raining", isOn: $rainNotification)
                        Toggle("Send a forecast notification in the morning", isOn: $forecastNotification)
                        
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
