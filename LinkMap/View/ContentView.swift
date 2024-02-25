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
                    .frame(height: 30)
                    .background(.green)
                    .cornerRadius(5)
                    .padding(2)
            }
            .frame(width: 200)

            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                    GridLayer(geometry: geometry)
                    ForEach(store.canvasBlocks) { block in
                        Text(block.text)
                            .frame(width: block.frame.width, height: block.frame.height)
                            .background(block.id == store.activeBlockId ? .orange : .blue)
                            .cornerRadius(5)
                            .padding(2)
                            .offset(
                                x: block.frame.midX - geometry.size.width/2 + store.canvasOffset.x,
                                y: block.frame.midY - geometry.size.height/2 + store.canvasOffset.y
                            )
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            store.onDragChanged(value: gesture)
                        }
                        .onEnded { gesture in
                            store.onDragEnded(value: gesture)
                        }
                )
                .onTapGesture(count: 2, perform: { location in
                    store.createBlockOnTap(point: location)
                })
                .onTapGesture(count: 1, perform: { location in
                    store.activateBlockIfPossible(
                        point: CGPoint(
                            x: location.x,
                            y: location.y
                        )
                    )
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
