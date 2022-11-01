//
//  SearchView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:[.orange,.blue]), startPoint: UnitPoint(x:1.9, y: -0.05), endPoint: UnitPoint(x: 0.4, y: 1))
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
