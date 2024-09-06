import SwiftUI
import AVFoundation
import Speech

struct TechniqueTimerView: View {
    let session: TrainingSession
    @State private var currentTechniqueIndex = 0
    @State private var techniques: [Technique] = []
    @State private var timer: Timer? = nil
    @State private var countdown = 10
    @State private var sessionComplete = false
    private let speechSynthesizer = AVSpeechSynthesizer()

    // Speech recognition properties
    private let speechRecognizer = SFSpeechRecognizer()
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var audioEngine = AVAudioEngine()

    var body: some View {
        VStack {
            // Show session completion message
            if sessionComplete {
                Text("Done! Ready to start a new session or some practice?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }
            // Show current technique and countdown
            else if currentTechniqueIndex < techniques.count {
                Text(techniques[currentTechniqueIndex].name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text("Next in \(countdown) seconds")
                    .font(.title)
                    .padding()
            }
            // Show session completion
            else {
                Text("Session Complete!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }

            // Show "Feet Together" status
            Text(session.isFeetTogetherEnabled ? "Feet Together: Enabled" : "Feet Together: Disabled")
                .font(.headline)
                .foregroundColor(session.isFeetTogetherEnabled ? .green : .red)
                .padding()
        }
        .onAppear {
            startTechniqueTimer()
            if session.isFeetTogetherEnabled {
                startListening()  // Start listening for the phrase if enabled
            }

            // Apply randomization if enabled
            techniques = session.randomizeTechniques ? session.techniques.shuffled() : session.techniques
        }
        .onDisappear {
            stopTimer()
            if session.isFeetTogetherEnabled {
                stopListening()  // Stop listening if it was enabled
            }
        }
        .navigationTitle(session.name)
    }

    private func startTechniqueTimer() {
        countdown = 10
        speakTechniqueName()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
            } else {
                moveToNextTechnique()
            }
        }
    }

    private func moveToNextTechnique() {
        if currentTechniqueIndex < techniques.count - 1 {
            currentTechniqueIndex += 1
            countdown = 10
            speakTechniqueName()
        } else {
            sessionComplete = true
            stopTimer()
        }
    }

    private func speakTechniqueName() {
        guard currentTechniqueIndex < session.techniques.count else {
            print("Error: currentTechniqueIndex is out of range.")
            return
        }
        
        let techniqueName = session.techniques[currentTechniqueIndex].name
        let utterance = AVSpeechUtterance(string: techniqueName)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    // Speech recognition functions
    private func startListening() {
        guard let recognizer = SFSpeechRecognizer(), recognizer.isAvailable else {
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try? audioEngine.start()

        recognitionTask = recognizer.recognitionTask(with: recognitionRequest!) { result, error in
            if let result = result {
                let spokenPhrase = result.bestTranscription.formattedString
                if spokenPhrase.lowercased().contains("feet together") {
                    self.triggerNextTechnique()
                }
            }

            if error != nil {
                self.stopListening()
            }
        }
    }

    private func stopListening() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
    }

    private func triggerNextTechnique() {
        // Provide audio feedback
        let utterance = AVSpeechUtterance(string: "Moving to next technique")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)

        // Move to the next technique after a brief delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.moveToNextTechnique()
        }
    }
}
