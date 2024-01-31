import Foundation
import SwiftUI

struct LoadingAnimation: View {
    @State private var isAnimating = false

    var body: some View {
        HStack {
            Circle()
                .frame(width: 10, height: 10)
                .scaleEffect(isAnimating ? 1 : 0.5)
            Circle()
                .frame(width: 10, height: 10)
                .scaleEffect(isAnimating ? 1 : 0.5)
            Circle()
                .frame(width: 10, height: 10)
                .scaleEffect(isAnimating ? 1 : 0.5)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    LoadingAnimation()
}
