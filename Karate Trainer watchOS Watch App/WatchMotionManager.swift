import WatchConnectivity
import CoreMotion
import Foundation

class WatchMotionManager: NSObject, ObservableObject, WCSessionDelegate {
    private var motionManager = CMMotionManager()
    private var session: WCSession
    private var gestureData = [(timestamp: Date, acceleration: CMAcceleration)]()
    private var isRecordingGesture = false

    override init() {
        session = WCSession.default
        super.init()
        session.delegate = self
        
        // Activate WCSession for communication with the iPhone
        if WCSession.isSupported() {
            session.activate()
        }
    }

    // Start monitoring device motion for gesture detection
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let self = self, let motion = motion else { return }
                if self.isRecordingGesture {
                    self.recordGesture(motion: motion)
                }
            }
        }
    }
    
    // Start recording the accelerometer data for the "Weapon Sheath" gesture
    func startRecordingGesture() {
        gestureData.removeAll()  // Clear any previous data
        isRecordingGesture = true
        print("Started recording accelerometer data...")
    }

    // Stop recording the gesture and print or save the values
    func stopRecordingGesture() {
        isRecordingGesture = false
        print("Finished recording gesture. Data: \(gestureData)")
        // You can store the data or save it for further processing
    }
    
    // Record accelerometer data during motion updates
    private func recordGesture(motion: CMDeviceMotion) {
        let acceleration = motion.userAcceleration
        gestureData.append((timestamp: Date(), acceleration: acceleration))
        
        // You can log or process the acceleration data here
        print("Acceleration recorded: \(acceleration)")
    }

    // WCSession delegate method
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WCSession activation failed with error: \(error)")
        } else {
            print("WCSession activated successfully.")
        }
    }
}
