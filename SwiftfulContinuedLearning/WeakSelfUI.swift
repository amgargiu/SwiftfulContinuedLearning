//
//  WeakSelfUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/14/25.
//

import SwiftUI

struct WeakSelfUI: View {
        
    @AppStorage("count") var count : Int?
    
    init(){
        count = 0
    }
    
    var body: some View {
        NavigationView{
            NavigationLink("Navigate") {
                WeakSelfSecondScreen()
            }
            .navigationTitle(Text("Screen 1"))
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(.green)
                .cornerRadius(20)
        , alignment: .topTrailing)
    }
}



// Second Screen view

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSeldSecondScreenViewModel()

    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundStyle(.red)
            
            if let data = vm.data { //if let since we set data from vm as optional string
                Text(data)
            }
        }
    }
}

// ViewModel for Second Screen View

class WeakSeldSecondScreenViewModel: ObservableObject {
    
    @Published var data : String? = nil
    
    init(){
        print("init now")
        // get current count - remember Appstorage uses user defaults (and only in views)
        // Using user defaults here since we are in class - not in a view (can use @AppStorage)
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("deinit now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        //simulating a task that might take a while
        DispatchQueue.main.asyncAfter(deadline: .now() + 300) { [weak self] in
            self?.data = "new data" // self is now optional
        }
        
    }
    
}



#Preview {
    WeakSelfUI()
}
