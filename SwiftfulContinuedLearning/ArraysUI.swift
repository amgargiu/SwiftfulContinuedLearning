//
//  ArraysUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/10/25.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}


class ArrayModViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []

    
    init() {
        getUser()
        updatefilteredArray()
    }
    
    func getUser() {
        let user1 = UserModel(name: "Antonio", points: 100, isVerified: true)
        let user2 = UserModel(name: "Gargiulo", points: 200, isVerified: false)
        let user3 = UserModel(name: nil, points: 300, isVerified: true)
        let user4 = UserModel(name: "lim", points: 400, isVerified: true)
        let user5 = UserModel(name: "mike", points: 500, isVerified: false)
        let user6 = UserModel(name: nil, points: 198, isVerified: true)
        let user7 = UserModel(name: "nate", points: 790, isVerified: false)

        dataArray.append(contentsOf: [user1, user2, user3, user4, user5, user6, user7])
    }
    
    func updatefilteredArray() {
        // SORT
        filteredArray = dataArray.sorted{( $0.points < $1.points )} // returns a bool
        
        // FILTER
        filteredArray = dataArray.filter ({ $0.points > 200})
        filteredArray = dataArray.filter ({ $0.isVerified})
        filteredArray = dataArray.filter ({ !$0.isVerified})
//        filteredArray = dataArray.filter ({ $0.name.contains("o")})

        // MAP
        mappedArray = dataArray.map({ $0.name ?? "Error"})
        mappedArray = dataArray.map { user in // mappedArray is type [String]
            user.name ?? "Error"
        }

        //COMPACT MAP
        
        mappedArray = dataArray.compactMap({ $0.name})

        
        
        
    }
    
}


struct ArraysUI: View {
    
    @StateObject var vm: ArrayModViewModel = ArrayModViewModel()
    
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 10) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
                
//                ForEach(vm.filteredArray) { user in
//                    VStack (alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack{
//                            Text("points are \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(.blue).cornerRadius(10)
//                    .padding(.horizontal)
//
//                }
            }
        }

    }
}

#Preview {
    ArraysUI()
}
