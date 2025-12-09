//
//  ScrollViewReaderUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/8/25.
//

import SwiftUI

struct ScrollViewReaderUI: View {
    
    @State var scrollToIndex : Int = 0
    @State var textFieldText: String = ""
    
    var body: some View {
        VStack {
            
            TextField("enter number...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                // optional since will try to mae string into it - possible it fails
                if let index = Int(textFieldText) {
                    scrollToIndex = index // variable instead of proxy - set to index we got from textfield
                }
                                
            }
            
            ScrollView {
                
                ScrollViewReader { proxy in
                    
                    
                    ForEach(0..<50) { index in
                        
                        Text("this is Item number #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding()
                            .id(index)
                        
                    }
                    .onChange(of: scrollToIndex) { value in
                        proxy.scrollTo(value, anchor: .top)
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderUI()
}
