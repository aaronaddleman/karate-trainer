//
//  FileManager.swift
//  Karate Trainer
//
//  Created by Aaron Addleman on 9/4/24.
//

import Foundation

// Paths to save data
func getDocumentsDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

func getTechniquesURL() -> URL {
    getDocumentsDirectory().appendingPathComponent("techniques.json")
}

func getTrainingSessionsURL() -> URL {
    getDocumentsDirectory().appendingPathComponent("trainingSessions.json")
}

// Saving data
func saveTechniques(_ techniques: [Technique]) {
    let url = getTechniquesURL()
    do {
        let data = try JSONEncoder().encode(techniques)
        try data.write(to: url)
    } catch {
        print("Failed to save techniques: \(error)")
    }
}

func saveTrainingSessions(_ sessions: [TrainingSession]) {
    let url = getTrainingSessionsURL()
    do {
        let data = try JSONEncoder().encode(sessions)
        try data.write(to: url)
    } catch {
        print("Failed to save training sessions: \(error)")
    }
}

// Loading data
func loadTechniques() -> [Technique] {
    let url = getTechniquesURL()
    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Technique].self, from: data)
    } catch {
        print("Failed to load techniques: \(error)")
        return []
    }
}

func loadTrainingSessions() -> [TrainingSession] {
    let url = getTrainingSessionsURL()
    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([TrainingSession].self, from: data)
    } catch {
        print("Failed to load training sessions: \(error)")
        return []
    }
}
