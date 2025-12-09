//
//  DragGesture2UI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/8/25.
//

import SwiftUI

struct DragGesture2UI: View {
    
    @State var startingOffsetY : CGFloat = UIScreen.main.bounds.height * 0.84
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            // BG Layer
            Color.green
                .ignoresSafeArea()
            
            // View
            SignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            //we want to change
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded { value in
                            
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0)) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                
                                currentDragOffsetY = 0

                            } // withAnimation
                        } // onEnded
                    )
            
            Text("\(currentDragOffsetY)")
            
        }
        .ignoresSafeArea(edges: .bottom)
        
    }
}

#Preview {
    DragGesture2UI()
}


struct SignUpView : View {
    
    var body : some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the decription for our app. This is my ffavorite swiftui course. recocomned doing this course and subscribe to swiftful thinking")
                .multilineTextAlignment(.center)
            
            Text("Create and Account")
                .foregroundStyle(Color.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(.black)
                .cornerRadius(10)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(30)
    }
}
