//
//  JSONCombineUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/21/25.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>() // place that we will store publisher - can access this variable to cancel it...
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        // first thing we need is a URL - optional this way
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        // write a function to actually download this data from the URL...
        
        //Combine Discussion:
        /*
        METAPHOR - sign up for package delivery subscription
        (1) sign up for monthly subscription for delivery
        (2) company makes package in factory
        (3) Receive package to your home
        (4) Makes sure box isn't damaged
        (5) Open and make sure item is correct
        (6) Use the item!
        (7) Cancellable at any time
    
        1 Create the publisher (company that offers subscription)
        2 Put / describe publisher onto background thread (done by default by Xcode - nick just doing it for practice)
        3 want to receive on the main thread so we can update UI
        4 tryMap (check that the dat is good) - did in last video w/ guards - this this is like mapping data x to data y (can "throw")
        5 decode (decode data into arry of PostModels)
        6 sink (put the item into our app)
        7 store (cancel subscription if needed - like savign the receipt...)
        */
        

        URLSession.shared.dataTaskPublisher(for: url) // will publish values over time...
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main) // go back to main thread after we set-up async task on global background thread
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            } receiveValue: { [weak self] (returnedPosts) in // if it was succesful - returned post will be of decoded type [PostModel]
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)

        
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data { // function for tryMap
        // takes inputs (data & response) - makes sure it's good - then returns it out s Data)
            // Makes data non-optional here to make sure it/s coming out of here
            //check that it is http response and valid
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw URLError(.badServerResponse)
        }
        // Access to data value from tryMap here after get past guard
        return output.data
    }
    
    
}


struct JSONCombineUI: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack (alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
    }
}

#Preview {
    JSONCombineUI()
}
