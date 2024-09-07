import SwiftUI
import AVFoundation
import WatchConnectivity

struct StartTrainingView: View {
    @State private var currentTechniqueIndex = 0
    @State private var isSessionComplete = false
    @State private var countdownActive = false
    @State private var countdownSeconds = 0
    @State private var countdownTimer: Timer?
    
    // Use iPhoneSessionManager as a normal instance
    private var sessionManager = iPhoneSessionManager()

    private var trainingSessions: [TrainingSession]
    private let speechSynthesizer = AVSpeechSynthesizer()

    init(trainingSessions: [TrainingSession]) {
        self.trainingSessions = trainingSessions
        // sessionManager.activateSession() is no longer needed
    }

    var body: some View {
        VStack {
            if isSessionComplete {
                Text("Session Complete!")
                    .font(.largeTitle)
                    .padding()
            } else if currentTechniqueIndex < trainingSessions[0].techniques.count {
                Text(trainingSessions[0].techniques[currentTechniqueIndex].name)
                    .font(.largeTitle)
                    .padding()
                    .onAppear {
                        startTechnique()
                    }
                
                if countdownActive {
                    Text("Next in \(countdownSeconds) seconds")
                        .font(.title)
                        .padding()
                }
                
                Button("Skip to Next Technique") {
                    moveToNextTechnique()
                }
                .padding()
            }
        }
    }
    
    // Start the current technique
    private func startTechnique() {
        // Speak the name of the current technique
        speakText(trainingSessions[0].techniques[currentTechniqueIndex].name)
    }

    // Start the countdown after the "Weapon Sheath" gesture is detected
    func startCountdown() {
        countdownActive = true
        countdownSeconds = 3
        speakText("Moving to next technique")
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.countdownSeconds > 0 {
                self.speakText("\(self.countdownSeconds)")
                self.countdownSeconds -= 1
            } else {
                self.countdownTimer?.invalidate()
                self.moveToNextTechnique()
                self.countdownActive = false
            }
        }
    }

    // Move to the next technique
    private func moveToNextTechnique() {
        if currentTechniqueIndex < trainingSessions[0].techniques.count - 1 {
            currentTechniqueIndex += 1
            startTechnique()
        } else {
            isSessionComplete = true
        }
    }

    // Stop the countdown if interrupted
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownActive = false
        speakText("Countdown stopped")
    }

    // Speak text using text-to-speech
    private func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }
}
