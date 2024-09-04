import SwiftUI
import AVFoundation

struct TechniqueTimerView: View {
    let session: TrainingSession
    @State private var currentTechniqueIndex = 0
    @State private var timer: Timer? = nil
    @State private var countdown = 10
    @State private var sessionComplete = false
    private let speechSynthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack {
            if sessionComplete {
                Text("Done! Ready to start a new session or some practice?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            } else if currentTechniqueIndex < session.techniques.count {
                Text(session.techniques[currentTechniqueIndex].name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Next in \(countdown) seconds")
                    .font(.title)
                    .padding()
            } else {
                Text("Session Complete!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }
        }
        .onAppear {
            startTechniqueTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .navigationTitle(session.name)
    }

    private func startTechniqueTimer() {
        countdown = 10 // Set the countdown duration
        speakTechniqueName() // Speak the first technique name
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
            } else {
                if currentTechniqueIndex < session.techniques.count - 1 {
                    currentTechniqueIndex += 1
                    countdown = 10 // Reset the countdown for the next technique
                    speakTechniqueName() // Speak the next technique name
                } else {
                    sessionComplete = true
                    stopTimer()
                }
            }
        }
    }

    private func speakTechniqueName() {
        let techniqueName = session.techniques[currentTechniqueIndex].name
        let utterance = AVSpeechUtterance(string: techniqueName)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
