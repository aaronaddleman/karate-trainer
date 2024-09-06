import SwiftUI

// Example of the selection row
struct TechniqueSelectionRow: View {
    var technique: Technique
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(technique.name)
            Spacer()
            Button(action: action) {
                Text(isSelected ? "On" : "Off")
                    .padding(8)
                    .background(isSelected ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
