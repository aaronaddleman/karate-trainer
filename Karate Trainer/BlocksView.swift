// BlocksView.swift

import SwiftUI

struct BlocksView: View {
    var body: some View {
        List {
            Text("High Block")
            Text("Low Block")
            Text("Middle Block")
        }
        .navigationTitle("Blocks")
    }
}
