//
//  LongPressGestureUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/8/25.
//

import SwiftUI

struct LongPressGestureUI: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack{
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth : isComplete ? .infinity : 0)
                .frame(height : 55)
                .frame(maxWidth : .infinity, alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("Press Me!")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) { (isPressing) in
                        //from Start of Press --> the min duration
                        if isPressing {
                            withAnimation(.easeOut(duration: 1)) {
                                isComplete = true
                            }
                        } else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform : {
                        //at the min duration - resulting action
                        withAnimation(.easeInOut){
                            isSuccess = true
                        }
                    }
                
                Text("RESET")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
        }
        
        
        
        
        
//        Text(isComplete ? "Completed" : "Not Complete!")
//            .padding(20)
//            .padding(.horizontal)
//            .background(isComplete ? .green : .gray)
//            .cornerRadius(10)
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 3, maximumDistance: 50) {
//                isComplete.toggle()
//            }
    }
    
    
}

#Preview {
    LongPressGestureUI()
}
