//
//  ContentView.swift
//  Karate Trainer
//
//  Created by Aaron Addleman on 8/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Karate Trainer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                NavigationLink(destination: StrikesView()) {
                    Text("Strikes")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: BlocksView()) {
                    Text("Blocks")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: PracticeModesView()) {
                    Text("Practice Modes")
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
}

struct StrikesView: View {
    var body: some View {
        List {
            Text("Twisting Punch")
            Text("Kick  ")
            Text("Uppercut")
        }
    }
}

struct BlocksView: View {
    var body: some View {
        List {
            Text("High Block")
            Text("Low Block")
            Text("Middle Block")
        }
    }
}

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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

