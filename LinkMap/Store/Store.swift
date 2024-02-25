//
//  Store.swift
//  LinkMap
//
//  Created by Olha Bachalo on 25/02/2024.
//

import SwiftUI
import os

private let logger = Logger(subsystem: "com.gatamar.LinkMap", category: "Store")

class Store: ObservableObject {
    private var nextId: UInt64 = 6
    @Published private(set) var activeBlockId: UInt64?
    @Published private(set) var pocketBlocks: [PocketBlock] = []
    @Published private(set) var canvasBlocks: [CanvasBlock] = []
    @Published private(set) var connections: [Connection] = []
    
    func loadAllMindMapStuff() {
        pocketBlocks = [
            .init(id: 2, text: "Not applicable"),
            .init(id: 4, text: "Yet another link so what"),
            .init(id: 5, text: "And one more please")
//            .init(id: 4, text: "ddd", frame: .init(x: 600, y: 400, width: 50, height: 30))
        ]
        
        canvasBlocks = [
            .init(id: 3, text: "sss", frame: .init(x: 0, y: 0, width: 100, height: 30))
//            .init(id: 4, text: "ddd", frame: .init(x: 600, y: 400, width: 50, height: 30))
        ]
        // read the block models from somewhere. can it be SwiftData?
        logger.error("loadAllMindMapStuff not implemented")
    }
    
    func activateBlockIfPossible(point: CGPoint) {
        activeBlockId = canvasBlocks.filter { $0.frame.contains(point) }.first?.id
    }

    func createBlockOnTap(point: CGPoint) {
        canvasBlocks.append(
            .init(id: nextId, text: "So here we have quite a long link", frame: .init(x: point.x-50, y: point.y - 15, width: 100, height: 30))
        )
        nextId += 1
    }
}
