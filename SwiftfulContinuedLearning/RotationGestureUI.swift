//
//  RotationGestureUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/8/25.
//

import SwiftUI

struct RotationGestureUI: View {
    
    @State var angle : Angle = .degrees(0)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(.blue)
            .cornerRadius(20)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        print("Rotated by \(value.degrees) degrees")
                        angle = value
                    }
                    .onEnded { value in
                        withAnimation(.smooth()) {
                            angle = .degrees(0)
                        }
                    }
                )
        
    }
}

#Preview {
    RotationGestureUI()
}
