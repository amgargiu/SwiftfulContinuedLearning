//
//  FileManagerUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 1/13/26.
//

import SwiftUI


class LocalFileManager { // make this a singleton
    
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    
    init () {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() { // create folder specifc to our app - use cashesDirectory -
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path
        else { return }
        
        // Make sure the folder doesn't exist (create - but not if it alreayd exists)
        
        if !FileManager.default.fileExists(atPath: path) { // if it doesn't exist - create folder
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("success creating folder")
            } catch let error {
                print("error creating folder \(error)")
            }
        }
            
    }
    
    
    func deleteFolder() {
        // get path to folder anme (not to specifc image)
        guard
            let path = FileManager // this path is a string
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path
        else { return }
        
        do {
            try FileManager.default.removeItem(atPath: path) // atPath: takes in path instring form
            print("success deleting folder")
        } catch let error {
            print("error deleting folder \(error)")
        }
        
        
    }
    
    
    func saveImage(image: UIImage, name: String) -> String {
        
        guard
            // percent of current quality
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name)
        else { // using func that returns path
            return "error getting data for image"
        }

        
        do {
            try data.write(to: path) // can throw so put in DTC
            print(path)
            return "success saving"
        } catch let error {
            return "error saving \(error)"
        }
        
        
    }
    
    
    func getImage(name: String) -> UIImage? { // need identifier of image (like name or D) and exact path where it was saved
        
        guard
            let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) // makes sure file actually exists at this path (string of path)
        else {
            print("error getting path")
            return nil
        }
        
        //  if we get the pth and file exits - then we get down here
        return UIImage(contentsOfFile: path)
    }
    
    
    func deleteImage(name: String) -> String {
        
        guard
            let path = getPathForImage(name: name), // keep as URl don't need it to be string
            FileManager.default.fileExists(atPath: path.path) // makes sure file actually exists at this path (strign of path)
        else {
            return "error getting path"
            
        }
        
        do {
            try FileManager.default.removeItem(at: path) // needs a URL - pass in path (from above)
            return "delete successful"
        } catch let error {
            return "error deleting image \(error)"
        }

    }
    
    
    
    //get path where we saved image
    func getPathForImage(name: String) -> URL? { // pass in an image name - return a URL? (URL and path the same thing)
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?// optional
                .appendingPathComponent(folderName) // appendingPathComp literally adds folder to path
                .appendingPathComponent("\(name).jpg") else {
            print("Error getting path")
            return nil // for iptional when we can't return URL
        }
        
        return path
    }
    
    
    
    
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName : String = "hali"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""
    
    
    init(){
        getImageFromAssetsFolder()
        //getImageFromFileManager()
    }
    
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName) // calls also getPAthForImage()
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
    
}





struct FileManagerUI: View {
    
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        
        
        NavigationView {
            VStack {
                
                if let image = vm.image { // unwrap optional image
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200,  height: 200)
                        .clipped()
                        .cornerRadius(70)
                }
                
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to Fm")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal, 40)
                            .background(Color.blue)
                            .cornerRadius(10)
                        
                    }
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete Image from fm")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal, 40)
                            .background(Color.red)
                            .cornerRadius(10)
                        
                    }
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
        
        
        
    }
}

#Preview {
    FileManagerUI()
}
