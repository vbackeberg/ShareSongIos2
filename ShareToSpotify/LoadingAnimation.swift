import Foundation
import SwiftUI

struct LoadingAnimation: View {
    var close: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            OscillatingDot(startDelay: TimeInterval(0.1))
            OscillatingDot(startDelay: TimeInterval(0.2))
            OscillatingDot(startDelay: TimeInterval(0.3))
        }
    }
}

struct OscillatingDot: View {
    @State private var offsetY: CGFloat = 0
    @State var startDelay: TimeInterval

    let animation = Animation
        .easeInOut(duration: 0.5)
        .repeatForever(autoreverses: true)

    var body: some View {
        Circle()
            .fill(Color.purple)
            .frame(width: 20, height: 20)
            .offset(y: offsetY)
            .onAppear {
                withAnimation(animation.delay(startDelay)) {
                    offsetY = 20
                }
            }
    }
}

#Preview {
    LoadingAnimation {}
}
