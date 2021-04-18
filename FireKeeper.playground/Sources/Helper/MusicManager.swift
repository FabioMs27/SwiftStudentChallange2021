import Foundation

import AVFoundation

public class MusicManager {
    public static let shared = MusicManager()
    private lazy var music: AVAudioPlayer = {
        guard let musicPath = Bundle.main.path(forResource: "Audio/MainMusic", ofType: "mp3"),
              let music = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicPath)) else {
            fatalError("Couldn't load music!")
        }
        music.numberOfLoops = -1
        music.prepareToPlay()
        music.volume = 0.1
        return music
    }()
    private var effectCollectable: AVAudioPlayer = {
        guard let path = Bundle.main.path(forResource: "Audio/CollectBurst", ofType: "mp3"),
              let sound = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Couldn't load music!")
        }
        sound.volume = 0.1
        return sound
    }()
    
    //Initializer
    private init() { }
    
    public func playMusic() {
        music.play()
    }
    
    public func playCollectable() {
        effectCollectable.prepareToPlay()
        effectCollectable.play()
    }
}
