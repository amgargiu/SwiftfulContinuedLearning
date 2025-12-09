//
//  MaskUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/9/25.
//

import SwiftUI

struct MaskUI: View {
    
    @State var rating : Int = 0
    
    var body: some View {
        
        ZStack {
            starsView
                .overlay(
                    overlayView
                        .mask(starsView)
                )
        }
        
    }
    
    private var starsView : some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
            
        }
    }
    
    private var overlayView : some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating)/5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    
}

#Preview {
    MaskUI()
}
