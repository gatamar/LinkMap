//
//  Store.swift
//  LinkMap
//
//  Created by Olha Bachalo on 25/02/2024.
//

import SwiftUI
import os

private let logger = Logger(subsystem: "com.gatamar.LinkMap", category: "Store")

typealias EntityID = UInt64

class Store: ObservableObject {
    private var nextId: EntityID = 6
    @Published private(set) var canvasOffset: CGPoint = .zero
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
    
    private func findBlockIfAny(under absoluteLocation: CGPoint) -> EntityID? {
        canvasBlocks.filter { $0.frame.contains(absoluteLocation) }.first?.id
    }
    
    func activateBlockIfPossible(point: CGPoint) {
        let absoluteLocation = CGPoint(
            x: point.x - canvasOffset.x,
            y: point.y - canvasOffset.y
        )
        activeBlockId = findBlockIfAny(under: absoluteLocation)
    }
    
    func createBlockOnTap(point: CGPoint) {
        canvasBlocks.append(
            .init(
                id: nextId,
                text: "So here we have quite a long link",
                frame: .init(
                    x: point.x - 50 - canvasOffset.x,
                    y: point.y - 15 - canvasOffset.y,
                    width: 100,
                    height: 30
                )
            )
        )
        nextId += 1
    }
    
    private var dragState: DragState = .none
    func onDragChanged(value: DragGesture.Value) {
        switch dragState {
        case .none:
            let absoluteLocation = CGPoint(
                x: value.location.x - canvasOffset.x,
                y: value.location.y - canvasOffset.y
            )
            if let blockId = findBlockIfAny(under: absoluteLocation) {
                dragState = .block(id: blockId, translation: value.translation)
                canvasBlocks = canvasBlocks.map({ block in
                    guard block.id == blockId else {
                        return block
                    }
                    return block.shifted(by: value.translation)
                })
            } else {
                dragState = .canvas(translation: value.translation)
                canvasOffset = CGPoint(
                    x: canvasOffset.x + value.translation.width,
                    y: canvasOffset.y + value.translation.height
                )
            }
        case .canvas(let prevTranslation):
            dragState = .canvas(translation: value.translation)
            canvasOffset = CGPoint(
                x: canvasOffset.x - prevTranslation.width + value.translation.width,
                y: canvasOffset.y - prevTranslation.height + value.translation.height
            )
        case .block(let id, let prevTranslation):
            dragState = .block(id: id, translation: value.translation)
            canvasBlocks = canvasBlocks.map({ block in
                guard block.id == id else {
                    return block
                }
                return block.shifted(
                    by: CGSize(
                        width: value.translation.width - prevTranslation.width,
                        height: value.translation.height - prevTranslation.height
                    )
                )
            })
        }
    }
    
    func onDragEnded(value: DragGesture.Value) {
        dragState = .none
    }
}

private enum DragState {
    case none
    case canvas(translation: CGSize)
    case block(id: EntityID, translation: CGSize)
}

private extension CanvasBlock {
    func shifted(by offset: CGSize) -> Self {
        .init(id: id, text: text, frame: CGRect(origin: CGPoint(x: frame.minX + offset.width, y: frame.minY + offset.height), size: frame.size))
    }
}
