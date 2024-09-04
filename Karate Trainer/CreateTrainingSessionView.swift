// CreateTrainingSessionView.swift

import SwiftUI

struct CreateTrainingSessionView: View {
    @Binding var techniques: [Technique]
    @State private var sessionName: String = ""
    @State private var selectedTechniques: [Technique] = []
    
    var body: some View {
        VStack {
            TextField("Session Name", text: $sessionName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List {
                ForEach(techniques) { technique in
                    HStack {
                        Text(technique.name)
                        Spacer()
                        if selectedTechniques.contains(where: { $0.id == technique.id }) {
                            Image(systemName: "checkmark")
                        }
                    }
                    .onTapGesture {
                        if let index = selectedTechniques.firstIndex(where: { $0.id == technique.id }) {
                            selectedTechniques.remove(at: index)
                        } else {
                            selectedTechniques.append(technique)
                        }
                    }
                }
            }
            
            Button(action: {
                // Handle saving the session here
                print("Session '\(sessionName)' created with \(selectedTechniques.count) techniques.")
            }) {
                Text("Save Training Session")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Create Training Session")
        .padding()
    }
}
