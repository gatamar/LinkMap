//
//  GridOverlay.swift
//  LinkMap
//
//  Created by Olha Bachalo on 25/02/2024.
//

import SwiftUI

struct GridLayer: View {
    private let horizontalSpacing: CGFloat = 48
    private let verticalSpacing: CGFloat = 48
    let geometry: GeometryProxy
    
    var body: some View {
        Path { path in
            let numberOfHorizontalGridLines = Int(geometry.size.height / self.verticalSpacing)
            let numberOfVerticalGridLines = Int(geometry.size.width / self.horizontalSpacing)
            for index in 0...numberOfVerticalGridLines {
                let vOffset: CGFloat = CGFloat(index) * self.horizontalSpacing
                path.move(to: CGPoint(x: vOffset, y: 0))
                path.addLine(to: CGPoint(x: vOffset, y: geometry.size.height))
            }
            for index in 0...numberOfHorizontalGridLines {
                let hOffset: CGFloat = CGFloat(index) * self.verticalSpacing
                path.move(to: CGPoint(x: 0, y: hOffset))
                path.addLine(to: CGPoint(x: geometry.size.width, y: hOffset))
            }
        }
        .stroke(Color.orange.opacity(0.4))
    }
}
