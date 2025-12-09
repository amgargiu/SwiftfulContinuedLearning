//
//  SoundEffectsUI.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/9/25.
//

import SwiftUI
import AVKit

class SoundManager {
    // Creating a single instance of the sound manager - initializing here once for whole app
    static let instance = SoundManager()
    
    //Variable not initlized in class - needs to be by init
    var player: AVAudioPlayer?
    
    enum soundOption: String {
        case tada = "Tada-sound" // he didnt add rawValue bexause he named hsi sounds exactly as the cases
        case badum = "Badum-tss"
    }
    
    func playSound(sound: soundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        //set up our player
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing dound \(error.localizedDescription)")
        }
            
    }
}

struct SoundEffectsUI: View {
    
    var soundManager: SoundManager = SoundManager()
    
    var body: some View {
        
        VStack(spacing: 40) {
            Button("Play Sound 1"){
                SoundManager.instance.playSound(sound: .tada)
            }
            Button("Play Sound 2"){
                SoundManager.instance.playSound(sound: .badum)
            }
        }
        
    }
}

#Preview {
    SoundEffectsUI()
}
