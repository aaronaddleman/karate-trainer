// TrainingSession.swift

import Foundation

struct TrainingSession: Identifiable {
    var id = UUID()
    var name: String
    var techniques: [Technique]
    var isFeetTogetherEnabled: Bool = false
    var randomizeTechniques: Bool = false
}
