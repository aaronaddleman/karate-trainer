// TrainingSession.swift

import Foundation

struct TrainingSession: Identifiable {
    var id = UUID()
    var name: String
    var techniques: [Technique]
    var timeBetweenTechniques: Int = 10
    var isFeetTogetherEnabled: Bool = false
    var randomizeTechniques: Bool = false
}
