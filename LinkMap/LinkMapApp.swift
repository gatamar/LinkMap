//
//  LinkMapApp.swift
//  LinkMap
//
//  Created by Olha Bachalo on 24/02/2024.
//

import SwiftUI

@main
struct LinkMapApp: App {
    @State var isGridVisible: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView(isGridVisible: $isGridVisible)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            // Handle primary action
                            print("Primary Action")
                        }) {
                            Label("Primary", systemImage: "star")
                        }
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            // Handle other action
                            print("Other Action")
                        }) {
                            Label("Other", systemImage: "heart")
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        SegmentedControlView()
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        ToggleGridItem(isGridVisible: $isGridVisible)
                    }
                }
        }
    }
}

struct SegmentedControlView: View {
    @State private var selectedScale = 1
    
    var body: some View {
        VStack {
            Text("Scale")

            Picker(selection: $selectedScale, label: Text("")) {
                Text("1x").tag(1)
                Text("2x").tag(2)
                Text("3x").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 150)
            .padding(.horizontal)
        }
    }
}

struct ToggleGridItem: View {
    @Binding var isGridVisible: Bool
    
    var body: some View {
        Toggle(isOn: $isGridVisible) {
            Label("Grid", systemImage: isGridVisible ? "square.grid.2x2.fill" : "square.grid.2x2")
        }
        .padding(.horizontal)
    }
}
