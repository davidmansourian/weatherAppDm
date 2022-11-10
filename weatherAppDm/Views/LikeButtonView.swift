//
//  LikeButtonView.swift
//  weatherAppDm
//
//  Created by David on 2022-11-10.
//

import SwiftUI

struct LikeButtonView: View {
    @State var isLiked = false
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.1)){
                isLiked.toggle()
            }
        } label: {
            if isLiked{
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
                    .padding(10)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            }
            else{
                Image(systemName: "heart")
                    .foregroundColor(Color.black)
                    .padding(10)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            }
        }
    }
}

struct LikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LikeButtonView()
    }
}
