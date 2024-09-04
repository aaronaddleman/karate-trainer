import SwiftUI

struct ModifyTrainingSessionsView: View {
    @Binding var trainingSessions: [TrainingSession]
    @Binding var allTechniques: [Technique]

    var body: some View {
        NavigationView {
            List {
                ForEach($trainingSessions) { $session in
                    NavigationLink(destination: EditSessionView(session: $session, allTechniques: $allTechniques)) {
                        Text(session.name)
                    }
                }
                .onDelete(perform: deleteSession)
            }
            .navigationTitle("Modify Training Sessions")
            .navigationBarItems(trailing: Button(action: addNewSession) {
                Image(systemName: "plus")
            })
        }
    }

    private func deleteSession(at offsets: IndexSet) {
        trainingSessions.remove(atOffsets: offsets)
    }

    private func addNewSession() {
        let newSession = TrainingSession(name: "New Session", techniques: [])
        trainingSessions.append(newSession)
    }
}
