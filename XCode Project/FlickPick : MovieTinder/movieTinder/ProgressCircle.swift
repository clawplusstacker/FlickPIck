//
//  ProgressCircle.swift
//  movieTinder
//
//  Created by Colby Beach on 1/31/22.
//

import Foundation
import SwiftUI


struct ProgressCircle: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, self.progress)/10))
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))

            Text(String(format: "%.0f%%", min(self.progress, self.progress)*10.0))
                .bold()
        }
    }
}
