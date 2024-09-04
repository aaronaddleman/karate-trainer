import SwiftUI

struct TechniquesView: View {
    @Binding var techniques: [Technique]
    @State private var newTechniqueName: String = ""
    @State private var newTechniqueCategory: String = ""

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Add New Technique")) {
                    TextField("Technique Name", text: $newTechniqueName)
                    TextField("Category", text: $newTechniqueCategory)
                    Button(action: addTechnique) {
                        Text("Add Technique")
                    }
                }

                Section(header: Text("Available Techniques")) {
                    List {
                        ForEach($techniques) { $technique in
                            NavigationLink(destination: EditTechniqueView(technique: $technique)) {
                                Text(technique.name)
                            }
                        }
                        .onDelete(perform: deleteTechnique)
                    }
                }
            }
        }
        .navigationTitle("Techniques")
    }

    private func addTechnique() {
        let newTechnique = Technique(name: newTechniqueName, category: newTechniqueCategory)
        techniques.append(newTechnique)
        newTechniqueName = ""
        newTechniqueCategory = ""
    }

    private func deleteTechnique(at offsets: IndexSet) {
        techniques.remove(atOffsets: offsets)
    }
}

struct EditTechniqueView: View {
    @Binding var technique: Technique

    var body: some View {
        Form {
            Section(header: Text("Edit Technique")) {
                TextField("Technique Name", text: $technique.name)
                TextField("Category", text: $technique.category)
            }
        }
        .navigationTitle("Edit Technique")
    }
}
