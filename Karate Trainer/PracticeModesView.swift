// PracticeModesView.swift

import SwiftUI

struct PracticeModesView: View {
    var body: some View {
        VStack {
            Text("Select Practice Mode")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                // code for sound off mode
            }) {
                Text("Sound off")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // Code for slow and smooth mode
            }) {
                Text("Slow and smooth")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // code for hard and strong mode
            }) {
                Text("Hard and Strong")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Practice Modes")
    }
}
