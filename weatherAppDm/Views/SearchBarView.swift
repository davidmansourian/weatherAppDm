//
//  SearchBarView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-02.
//

import SwiftUI

struct SearchBarView: View {
    @State var searchString: String = ""
    var body: some View {
        HStack{
            TextField("Search locations...", text: $searchString)
                .foregroundColor(Color.white)
        }
        .font(.headline)
        .padding()
        .background(
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .cornerRadius(20)
                .shadow(radius: 8)
                .opacity(0.2))
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
