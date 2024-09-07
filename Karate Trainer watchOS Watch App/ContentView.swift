import SwiftUI
import CoreMotion

struct ContentView: View {
    @StateObject var watchMotionManager = WatchMotionManager()
    @State private var isRecording = false  // Track whether recording is active

    var body: some View {
        VStack {
            Text("Karate Trainer")
                .font(.headline)
                .padding()

            // Button to start training session (motion detection)
            Button("Start Training") {
                watchMotionManager.startMotionUpdates()
            }
            .padding()

            // Button to start or stop recording accelerometer values
            if isRecording {
                Button("Stop Recording Weapon Sheath Gesture") {
                    watchMotionManager.stopRecordingGesture()
                    isRecording = false  // Update state to reflect stopped recording
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Button("Record Weapon Sheath Gesture") {
                    watchMotionManager.startRecordingGesture()
                    isRecording = true  // Update state to reflect active recording
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}
