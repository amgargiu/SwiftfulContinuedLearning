//
//  GeometryReaderUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/9/25.
//

import SwiftUI

struct GeometryReaderUI: View {
    
    let maxDistance = UIScreen.main.bounds.width / 2 //this will get us size of/to center screen
    
    
    var body: some View {
        
        Text("max distance in func:    \(maxDistance)")
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        let currentX = geometry.frame(in: .global).midX
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .rotation3DEffect(
                                    Angle(degrees: getPercentage(geo: geometry)*40),
                                    axis: (x: 0, y: 1, z: 0))
                            
                            Text("\(currentX)")
                                .foregroundStyle(Color.red).font(.title2).fontWeight(.bold)
                        }
                            
                        
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        
        
        
//        GeometryReader { geometry in
//            HStack (spacing: 0) {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: geometry.size.width * 0.66666)
//                Rectangle()
//                    .fill(.blue)
//            }
//            .ignoresSafeArea()
//        }
        
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2 //this will get us size of/to center screen
        let currentX = geo.frame(in: .global).midX //will give us the middle X coordinate of VIEW
        return Double(1 - (currentX / maxDistance))
        
    }
    
}

#Preview {
    GeometryReaderUI()
}
