//
//  SearchView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI

struct SearchView: View {
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
                .cornerRadius(20)
                .shadow(radius: 8)
                .opacity(0.2))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
