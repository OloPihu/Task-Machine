//
//  SoundService.swift
//  Task Machine!
//
//  Created by Aleksander  on 03/08/2019.
//

import Foundation
import AVFoundation

class SoundService {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundObjects {
        
        case tear
        case newPage
        
    }
    
    static func playSounds(_ effect:SoundObjects) {
        
        var soundName = ""
        
        switch effect {
            
        case .tear:
            soundName = "tearPaper"
        case .newPage:
            soundName = "turnPage"
            
        }
        
        let bundlePath = Bundle.main.path(forResource: soundName, ofType: "wav")
        
        guard bundlePath != nil else {
            
            print("Couldn't find sound file named \(soundName) in the bundle")
            return
            
        }
        
        let soundUrl = URL(fileURLWithPath: bundlePath!)
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            
            audioPlayer?.play()
            
        }
        catch {
            
            print("Couldn't create the audio player object for sound file \(soundName)")
            
        }
    }
    
    
    
}
