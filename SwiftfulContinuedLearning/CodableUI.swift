//
//  CodableUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/20/25.
//

import SwiftUI

// Codable = Decodable + Encodable

struct CustomerModel: Identifiable, Codable {
    let id : String
    let name: String
    let points: Int
    let isPremium: Bool
    
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    // Coding keys to DECODE from JSON data to CustomerModel
    enum CodingKeys: String, CodingKey { // give kets we are looking for in JSON data
        case id
        case name
        case points
        case isPremium
    }
    
    // decoding from json data into our customer model
    init(from decoder: any Decoder) throws {
        // container is container inside decoder which holds the json data
        let container = try decoder.container(keyedBy: CodingKeys.self) // give keys it should look for
        // Set up values based on container - like we do for normal init
        self.id = try container.decode(String.self, forKey: .id) // for decode - tell it data type + enum case
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    // Encodable function to turn CustomerModels into JSON data (maybe to re-upload to internet)
    
    func encode(to encoder: any Encoder) throws {
        //here create a blank container - and we need to add the values to it (unlike decode containe rhad data we needed to strop from it
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id) // pass in the actual property name, give the key it should go to
        try container.encode(name, forKey: .name)
        try container.encode(points, forKey: .points)
        try container.encode(isPremium, forKey: .isPremium)
    }
    
    
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
//    CustomerModel(id: "1", name: "nivk", points: 5, isPremium: true)
    
    init() {
        getData()
        
    }
    
    func getData(){
        guard let data = getJSONData() else { return } // this func returns optional Data?
        
        // decoding Data? (dictionary) from func below from JSON data to CustomerModel in one line
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
        
        // SAMEEE as above but written out with DTC
        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data) // give exact type to decode to
        } catch let error {
            print(error)
        }

        
        
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data),
//            let dictionary = localData as? [String: Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool {
//            
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
        
    }
    
    func getJSONData() -> Data? { // in real app this would return as data from internet, optional as possible download fails
        
        //fake json object to convert into json data
        let dictionaryObject: [String: Any] = [
            "id" : "1",
            "name" : "nivk",
            "points" : 5,
            "isPremium" : true
        ]
        //conver fake  data into Json data
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionaryObject) //optional data same as return type
        
        // End of video re-doing fake data with Encode
        
        // Enoding to create our fake JSON object (just create model and convert it to json with encode)
        let customer = CustomerModel(id: "444", name: "mike", points: 54, isPremium: false)
        let jsonData2 = try? JSONEncoder().encode(customer)
        
        return jsonData2
    }
    
}

struct CodableUI: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        
        VStack (spacing: 20){
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)

            }
        }
    }
}

#Preview {
    CodableUI()
}
