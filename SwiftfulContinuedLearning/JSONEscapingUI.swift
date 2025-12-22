//
//  DownloadJSONEscapingUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/21/25.
//

import SwiftUI

//struct PostModel: Identifiable, Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}


class DownloadJSONEscapingViewModel : ObservableObject {
    
    @Published var posts : [PostModel] = []
    
    init() {
        getPosts()
    }
    
    
    func getPosts() {
        // creating URL like this optional (dead link)
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        downloadData(fromURL: url) { returnedData in //from completion handler
            if let data = returnedData {
                // guard that tries to decode JSON (returned data) and then updates View (appends)
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in // Editing UI (@Published) need to go back to thread 1 (main)
                    self?.posts = newPosts // MAKE SELF OPTIONAL when use weak self
                }
                
            } else {
                print("no data returned")
            }
        }
        
        
        // generic func to use for any URL with data - returns us generic data
        // Used to download from internet - .dataTask automatically brings us to a background thread
        func downloadData(fromURL url: URL, completion: @escaping ( _ data: Data?) -> ()) { // asynx work
            URLSession.shared.dataTask(with: url) { data, response, error in // get optional data, response, error
                guard
                    let data = data,
                    error == nil,
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    completion(nil)
                    print("error downloading data \(error)")
                    return
                }
                print("success downloadData function")
                // after get past guard - got data and know we have - call the @escaping function...
                completion(data) // pass in data
                
            }.resume() // the "start" task function - need to execute code above
        } // END Func
        
    }
}


struct JSONEscapingUI: View {
    
    @StateObject var vm = DownloadJSONEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack (alignment: .leading){
                    Text(post.title)
                        . font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    JSONEscapingUI()
}
