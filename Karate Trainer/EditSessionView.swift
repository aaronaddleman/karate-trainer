import SwiftUI

struct EditSessionView: View {
    @Binding var session: TrainingSession
    @Binding var allTechniques: [Technique]
    @State private var isFeetTogetherEnabled: Bool = false // Toggle state for voice command
    @State private var randomizeTechniques: Bool = false // Toggle state for randomizing techniques

    var body: some View {
        Form {
            Section(header: Text("Session Name")) {
                TextField("Session Name", text: $session.name)
            }

            Section(header: Text("Selected Techniques")) {
                List {
                    ForEach(session.techniques) { technique in
                        Text(technique.name)
                    }
                    .onDelete(perform: removeTechnique)
                }
            }

            Section(header: Text("Add Techniques")) {
                List(allTechniques) { technique in
                    MultipleSelectionRow(title: technique.name, isSelected: session.techniques.contains(where: { $0.id == technique.id })) {
                        toggleTechniqueSelection(technique: technique)
                    }
                }
            }

            Section(header: Text("Settings")) {
                Toggle("Enable 'Feet Together'", isOn: $isFeetTogetherEnabled)
                    .onChange(of: isFeetTogetherEnabled) { value in
                        session.isFeetTogetherEnabled = value
                    }

                Toggle("Randomize Techniques", isOn: $randomizeTechniques)
                    .onChange(of: randomizeTechniques) { value in
                        session.randomizeTechniques = value
                    }
            }
        }
        .navigationTitle("Edit \(session.name)")
    }

    private func toggleTechniqueSelection(technique: Technique) {
        if let index = session.techniques.firstIndex(where: { $0.id == technique.id }) {
            session.techniques.remove(at: index)
        } else {
            session.techniques.append(technique)
        }
    }

    private func removeTechnique(at offsets: IndexSet) {
        session.techniques.remove(atOffsets: offsets)
    }
}


// Assuming this struct is already in your code
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
