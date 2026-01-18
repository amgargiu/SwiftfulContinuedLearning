//
//  CoreDataMVVMUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/12/25.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    //preview
    //shared
    //container of type NSPersistentContainer
    //- give it name of core data file within init
    //use container .loadPersistentStores function
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data \(error)")
            } else {
                print("success loading CoreData")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetching \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext) // init FruitEntity and put in context
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(IndexSet: IndexSet) {
        //find it
        guard let Index = IndexSet.first else {return} //  1 IndexSet passed in, still unwrap .first opt
        let fruitToDelete = savedEntities[Index]
        //.delete it w/ viewContext
        container.viewContext.delete(fruitToDelete)
        //save
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        guard let fruitToUpdateName = entity.name else {return} //optional since might not have name
        let newName = fruitToUpdateName + "!"
        entity.name = newName
        saveData()
    }
    
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("error saving \(error)")
        }
    }
    
    
}


// MARK: VIEW


struct CoreDataMVVMUI: View {
    
    @StateObject var vm: CoreDataViewModel = CoreDataViewModel()
    @State var textField: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                TextField("add fruit here...", text: $textField)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    //make sure at least one charcater
                    guard !textField.isEmpty else {return}
                    vm.addFruit(text: textField)
                    textField = ""
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.003921568627, green: 0.5803921569, blue: 0.9764705882, alpha: 1)))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "No Name") //optional since entiy might not have name
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit) // don't need to pass in IndexSet since swiping on list item is inherintly passing in an indexSet
                }
                .listStyle(PlainListStyle())

                
            }
            .navigationTitle(Text("Fruits"))
        }
    }
}

#Preview {
    CoreDataMVVMUI()
}
