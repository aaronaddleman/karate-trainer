// Techniques.swift
import Foundation

struct Technique: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var category: String
    
    // Manually conform to Equatable
    static func == (lhs: Technique, rhs: Technique) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

let predefinedTechniques = [
    Technique(name: "Kimono Grab", category: "White"),
    Technique(name: "Eagles Beak A", category: "White"),
    Technique(name: "Eagles Beak B", category: "White"),
    Technique(name: "Striking Asp A", category: "White"),
    Technique(name: "Striking Asp B", category: "White"),
    Technique(name: "Crash of the Eagle A", category: "White"),
    Technique(name: "Crash of the Eagle B", category: "White"),
    Technique(name: "Crash of the Eagle C", category: "White"),
    Technique(name: "Crash of the Eagle D", category: "White"),
]
