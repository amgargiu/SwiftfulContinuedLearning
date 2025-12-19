//
//  EscapingUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/15/25.
//

import SwiftUI


class EscapingViewModel : ObservableObject {
    
    @Published var text: String = "Hello!"
    
    func getData() {
        
        downloadData5 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
        
//        downloadData3 { [weak self] returnedData in //  weak self to allow async task + ViewModel to De-init if user leaves
//            self?.text = returnedData // telling Xcode ut's okay if we want to de-init this class and not run this
//        }
    }
    
    
    func downloadData() -> String { // regular return type - synchronous (lines run in order, immediate)
        return "New Data!"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void) { // not returning anything explicitly - void
        // simulate going to database with delay
        // error, regular return function want to return immedietly (sunchronous)
        completionHandler("new data") // as soon as we call this - it executes the sub-func in parameter...
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) { // made it an escaping, no asynchronous
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("new data")
        }
    }
    
    //Making DD3 more readable
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) { // made it an escaping, no asynchronous
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "new data")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) { // made it an escaping, no asynchronous
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "new data")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()


struct EscapingUI: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(Color.blue)
            .onTapGesture {
                vm.getData()
            }
        
    }
}

#Preview {
    EscapingUI()
}
