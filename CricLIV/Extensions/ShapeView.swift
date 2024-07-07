//
//  ShapeView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 20/06/24.
//

import SwiftUI

struct ShapeView: View {
    var controlPoint = 0.0
    var body: some View {
        MyIcon(controlPoint: controlPoint)
            .stroke(.blue, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

            .frame(width: 400, height: 280)
            .offset(x: 5, y: 16)
    }
}

#Preview {
    ShapeView()
}
