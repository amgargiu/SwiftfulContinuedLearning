//
//  TimerUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 1/12/26.
//

import SwiftUI

struct TimerUI: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // Current time going up
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    //Coundown
    /*
    @State var count: Int = 10
    @State var finishedText: String?
    */
    
    //Countdown to Date
    /*
    @State var timeRemaining: String = ""
    let futureData: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureData)
        // get each component from above value...
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(minute):\(second)"
    }
    */
    
    //Animation Counter
    @State var count: Int = 1
    
    
    var body: some View {
        ZStack{
            
            RadialGradient(
                colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color.purple],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $count) {
                Rectangle()
                    .fill(.red)
                    .tag(1)
                Rectangle()
                    .fill(.green)
                    .tag(2)
                Rectangle()
                    .fill(.blue)
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 200)
            
            
            
            
        }
        .onReceive(timer) { _ in
//            if count == 3 {
//                count = 0
//            }
//            count += 1
            withAnimation(.default) {
                count = count == 3 ? 1 : count + 1
            }
        }
        
        
    }
}

#Preview {
    TimerUI()
}
