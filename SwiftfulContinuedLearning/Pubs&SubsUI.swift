//
//  Pubs&SubsUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 1/12/26.
//

import SwiftUI
import Combine


class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0 // @Published will publish values
    var cancellables = Set<AnyCancellable>() // use with .store - can cancel multiple publishers...
    
    @Published var textFieldText : String = ""
    @Published var textIsValid : Bool = false
    
    @Published var showButton : Bool = false
    
    init(){
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    
    // function to subscrube to the @Published var textField above
    func addTextFieldSubscriber() {
        // listen to @Publoshed by binding
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // commonly used for searching in textfield
            .map { text -> Bool in // when we receive text data from publosher - lets transofmr data
                if text.count > 3 {
                    return true
                }
                return false
            }
            //.assign(to: \.textIsValid, on: self) // similar sink-use data here-assigning bool to class variable
            .sink(receiveValue: { [weak self] isValid in /// better since use weak self
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    
    func setUpTimer(){
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in // need to store this somehwere so can cancel it
                
                // If self is valid makes this more safe... checking it
                guard let self = self else { return } // checking that self is valid
                // if we cn set new variable caled white self into weak optional var self - the we can keep going
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid // subscribing to this - meaning everytime it updates - we get a new value and run actions
            .combineLatest($count) // now listening to both textIsValid and coutn @Published var - thats 2
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count > 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
}

struct Pubs_SubsUI: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            
            TextField("title here", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                .cornerRadius(10)
                .overlay (
                    ZStack{
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                // if no text - nothing - if text started X
                                vm.textFieldText.isEmpty ? 0 :
                                vm.textIsValid ? 0 : 1
                            )
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1 : 0)
                    }
                    .font(.headline)
                    .padding(.trailing)
                    
                    , alignment: .trailing
                )
            
            
            Button {
                //
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1 : 0.5)
            }
            .disabled(!vm.showButton) // if showButton is false xcannot click button


            
            
        }
        .padding()
        
    }
}

#Preview {
    Pubs_SubsUI()
}
