// TrainingSession.swift

import Foundation

struct TrainingSession: Identifiable {
    var id = UUID() // Unique identifier for each session
    var name: String // Name of the session
    var techniques: [Technique] // List of techniques in the session
}
