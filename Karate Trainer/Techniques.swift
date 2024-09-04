// Techniques.swift
import Foundation

struct Technique: Identifiable {
    var id = UUID() // unique identifier for each technique
    var name: String // name of the technique
    var category: String // Category
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
