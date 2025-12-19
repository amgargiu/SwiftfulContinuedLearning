//
//  BackgroundThreadUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/14/25.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    
    // public func we can call from views
    func fetchData() { //will call other func downloadData
        
        DispatchQueue.global(qos: .background).async {
            let downloadedData = self.downloadData() // can do this since it returns data array
            
            print(" Check: 1: \(Thread.isMainThread)")
            print(" Check: 1: \(Thread.current)")
            Thread.isMainThread // checking if on main thread - will tell us
            Thread.current // get current thread we are on
            
            DispatchQueue.main.async {
                self.dataArray = downloadedData
                
                print(" Check: 2: \(Thread.isMainThread)")
                print(" Check: 2: \(Thread.current)")
            }
        }
    }
    
    // private means can only be accessed from this file (cant go vm.func in view)
    private func downloadData() -> [String] { // returning some data, In real app this downloads from internet
        var data : [String] = [] // store values in array named "data"
        for x in 1..<100 {
            data.append( "Item \(x)") // appending strings to array
            print(data)
        }
        return data // return type
    }
    
    
}


struct BackgroundThreadUI: View {
    
    @StateObject var vm: BackgroundThreadViewModel = BackgroundThreadViewModel()
    
    var body: some View {
        
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load Title")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
        
        
        
    }
}

#Preview {
    BackgroundThreadUI()
}
