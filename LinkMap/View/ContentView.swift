//
//  ContentView.swift
//  LinkMap
//
//  Created by Olha Bachalo on 24/02/2024.
//

import SwiftUI
import os

struct ContentView: View {
    @ObservedObject var store: Store = Store()
    var body: some View {
        HStack {
            List(store.pocketBlocks) { block in
                Text(block.text)
            }
            .frame(width: 200)

            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                    GridLayer(geometry: geometry)
                    ForEach(store.canvasBlocks) { block in
                        Text(block.text)
                            .frame(width: block.frame.width, height: block.frame.height)
                            .background(.purple)
                            .cornerRadius(5)
                            .padding(2)
                            .offset(
                                x: block.frame.midX - geometry.size.width/2,
                                y: block.frame.midY - geometry.size.height/2
                            )
                    }
                }
                .onTapGesture(count: 2, perform: { location in
                    store.createBlockOnTap(point: location)
                })
                .onTapGesture(count: 1, perform: { location in
                    store.activateBlockIfPossible(point: location)
                })
            }
        }
        .onAppear(perform: {
            store.loadAllMindMapStuff()
        })
    }
}

#Preview {
    ContentView()
}
