//
//  TypeAliasUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/14/25.
//

import SwiftUI


struct MovieModel {
    let title: String
    let director : String
    let count: Int
}

typealias TVModel = MovieModel

struct TypeAliasUI: View {
    
    @State var item : MovieModel = MovieModel(title: "The Shawshank Redemption", director: "Frank Darabont", count: 1000)
    @State var item2 : TVModel = TVModel(title: "The Shawshank Redemption", director: "Frank Darabont", count: 1000)
    
    var body: some View {
        VStack{
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")

        }
    }
}

#Preview {
    TypeAliasUI()
}
