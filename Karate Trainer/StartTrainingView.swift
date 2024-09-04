import SwiftUI

struct StartTrainingView: View {
    @State private var trainingSessions: [TrainingSession]
    
    // The initializer now accepts a list of training sessions
    init(trainingSessions: [TrainingSession]) {
        _trainingSessions = State(initialValue: trainingSessions)
    }
    
    var body: some View {
        VStack {
            if trainingSessions.isEmpty {
                Text("No training sessions available")
                    .font(.headline)
                    .padding()
            } else {
                List(trainingSessions) { session in
                    NavigationLink(destination: TechniqueTimerView(session: session)) {
                        Text(session.name)
                    }
                }
            }
        }
        .navigationTitle("Start Training")
    }
}
