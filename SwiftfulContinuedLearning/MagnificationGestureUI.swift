//
//  MagnificationGestureUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/8/25.
//

import SwiftUI

struct MagnificationGestureUI: View {
    
    @State var currentAmt : CGFloat = 0
    @State var lastAmt : CGFloat = 0

    
    var body: some View {
        
        VStack (spacing: 10) {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                Text("Hello, World!")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
           
            Rectangle()
                .scaleEffect(1.0 + currentAmt)
                .frame(height: 300)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            if currentAmt >= 0 && currentAmt <= 1 {
                                currentAmt = value - 1
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring) {
                                currentAmt = 0
                            }
                        }
                )
            
            
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            
            Text("this is the capiton of my photo here!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
        
        
//        Text("Hello, World!")
//            .font(.title)
//            .padding(40)
//            .background(.red)
//            .cornerRadius(10)
//            .scaleEffect(1.0 + currentAmt + lastAmt)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { value in
//                        currentAmt = value - 1
//                    }
//                    .onEnded { value in
//                        //lastAmt = lastAmt + currentAmt
//                        lastAmt += currentAmt //will track on end what current amount was
//                        // reset currentAmt (amount increase) to 0 again once we do this
//                        // Will be edited on change next magnification
//                        currentAmt = 0
//                    }
//                
//            )
        
    }
}

#Preview {
    MagnificationGestureUI()
}
