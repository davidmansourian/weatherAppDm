//
//  SearchView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack{
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .cornerRadius(20)
                .shadow(radius: 5)
                .opacity(0.5)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
