//
//  DragGestureUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/8/25.
//

import SwiftUI

struct DragGestureUI: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            VStack{
                Text("\(offset.width)")
                
                Spacer()
            }
            
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in // translation b/w where it is now - where we drag it to
                            offset = value.translation
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
                )
        }
    }
    
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmt = abs(offset.width) // tracking this
        let percentage = currentAmt / max
        return 1 - min(percentage, 0.5) * 0.5
    }
    
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmt = offset.width // no abs here - sign lets us know when L/R
        let percentage = currentAmt / max
        let percentageAsDouble = Double(percentage)
        let maxAngle : Double = 10
        return percentageAsDouble * maxAngle // when percent is maxed at 1.0 - get 10 degrees
    }
    
}

#Preview {
    DragGestureUI()
}
