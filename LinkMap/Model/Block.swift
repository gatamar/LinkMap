//
//  Block.swift
//  LinkMap
//
//  Created by Olha Bachalo on 25/02/2024.
//

import SwiftUI

struct PocketBlock: Identifiable {
    let id: UInt64
    let text: String
}

struct CanvasBlock: Identifiable {
    let id: UInt64
    let text: String
    let frame: CGRect
}

struct Connection: Identifiable {
    let id: UInt64
    let block1: UInt64
    let block2: UInt64
}
