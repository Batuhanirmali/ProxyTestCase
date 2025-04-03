//
//  ChapterProgressBar.swift
//  ProxyCodeCaseStudy
//
//  Created by Talha Batuhan Irmalı on 3.04.2025.
//

import SwiftUI

struct ChapterProgressBar: View {
    let durations: [Double]
    let current: Int

    var body: some View {
        HStack(spacing: 4) {
            let minWidth: CGFloat = 4
            let totalSpacing = CGFloat(durations.count - 1) * 4
            let availableWidth = UIScreen.main.bounds.width - totalSpacing
            let totalDuration = durations.reduce(0, +)

            let baseWidth = CGFloat(durations.count) * minWidth
            let remainingWidth = max(0, availableWidth - baseWidth)

            ForEach(0..<durations.count, id: \.self) { index in
                let ratio = durations[index] / totalDuration
                let width = minWidth + (remainingWidth * ratio)

                Rectangle()
                    .fill(index <= current ? Color(hex: "#F7C663") : Color(.systemGray5))
                    .frame(width: width, height: 4)
                    .animation(.easeInOut(duration: 0.3), value: current)
            }
        }
    }
}
