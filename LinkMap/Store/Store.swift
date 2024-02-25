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
    private var nextId: UInt64 = 5
    @Published var blocks: [Block] = []
    @Published var connections: [Connection] = []
    
    func loadAllMindMapStuff() {
        blocks = [
            .init(id: 3, text: "sss", frame: .init(x: 0, y: 0, width: 100, height: 30))
//            .init(id: 4, text: "ddd", frame: .init(x: 600, y: 400, width: 50, height: 30))
        ]
        // read the block models from somewhere. can it be SwiftData?
        logger.error("loadAllMindMapStuff not implemented")
    }
    
    func createBlockOnTap(point: CGPoint) {
        blocks.append(
            .init(id: nextId, text: "So here we have quite a long link", frame: .init(x: point.x-50, y: point.y - 15, width: 100, height: 30))
        )
        nextId += 1
    }
}
