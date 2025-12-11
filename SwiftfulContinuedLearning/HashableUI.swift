//
//  HashableUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/9/25.
//

import SwiftUI

struct MyModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}


struct HashableUI: View {
    
    let data : [MyModel] = [
        MyModel(title: "one"),
        MyModel(title: "two"),
        MyModel(title: "three")
    ]
    
    var body: some View {
        
        ScrollView{
            VStack (spacing: 40){
                ForEach(data, id: \.self) { item in
                    Text("This is \(item.hashValue.description)")
                        .font(.headline)
                }
            }
        }
        
    }
}

#Preview {
    HashableUI()
}
