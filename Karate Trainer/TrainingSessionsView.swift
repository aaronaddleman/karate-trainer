import SwiftUI

struct TrainingSessionsView: View {
    @State private var trainingSessions: [TrainingSession] = [
        TrainingSession(name: "Session 1", techniques: [
            Technique(name: "Technique 1", category: "a"),
            Technique(name: "Technique 2", category: "a")
        ]),
        TrainingSession(name: "Session 2", techniques: [
            Technique(name: "Technique 3", category: "b"),
            Technique(name: "Technique 4", category: "b")
        ])
    ]
    
    @State private var allTechniques: [Technique] = [
        Technique(name: "Technique 1", category: "a"),
        Technique(name: "Technique 2", category: "a"),
        Technique(name: "Technique 3", category: "b"),
        Technique(name: "Technique 4", category: "b")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Training Sessions")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            NavigationLink(destination: StartTrainingView(trainingSessions: trainingSessions)) {
                Text("Start Training")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            NavigationLink(destination: ModifyTrainingSessionsView(trainingSessions: $trainingSessions, allTechniques: $allTechniques)) {
                Text("Modify Training Sessions")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
