import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    private var player: AVAudioPlayer?
    
    func playSound(_ filename: String) {
        guard let soundFilename = filename.components(separatedBy: ".").first else {
            print("Invalid filename format")
            return
        }
        
        guard let url = Bundle.main.url(forResource: soundFilename, withExtension: "mp3") else {
            print("wheres the damn sound: \(soundFilename).mp3")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("e: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        player?.stop()
        player = nil
    }
}
