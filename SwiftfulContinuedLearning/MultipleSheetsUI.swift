//
//  MultipleSheetsUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/9/25.
//

import SwiftUI

//Create model to use
struct RandomModel : Identifiable {
    let id = UUID().uuidString
    let title: String
}



struct MultipleSheetsUI: View {
    
//    @State var selectedModel : RandomModel = RandomModel(title: "Starting Title")
    @State var selectedModel2 : RandomModel? = nil
    
    var body: some View {
        
        VStack (spacing: 20){
            
            Button("Go to Sheet 1"){
                //update to new model
//                selectedModel = RandomModel(title: "ONE")
                selectedModel2 = RandomModel(title: "ONE")
            }
            
            Button("Go to Sheet 2"){
//                selectedModel = RandomModel(title: "TWO")
                selectedModel2 = RandomModel(title: "ONE")

            }
            
        }
        .sheet(item: $selectedModel2) { model in
            NextScreen(selectedModel: model)
        }
        
    }
}

#Preview {
    MultipleSheetsUI()
}


struct NextScreen : View {
    
    let selectedModel : RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}
