import SwiftUI

struct EditSessionView: View {
    @Binding var session: TrainingSession
    @Binding var allTechniques: [Technique]

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

// Add this below the EditSessionView struct
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
