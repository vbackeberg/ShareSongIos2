import Foundation
import SwiftUI

struct LoadingAnimation: View {
    var close:(() -> Void)
    @State private var isAnimating = false

    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 20, height: 20)
                    .scaleEffect(isAnimating ? 1 : 0.5)
                Circle()
                    .frame(width: 20, height: 20)
                    .scaleEffect(isAnimating ? 1 : 0.5)
                Circle()
                    .frame(width: 20, height: 20)
                    .scaleEffect(isAnimating ? 1 : 0.5)
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
                    isAnimating = true
                }
            }
        }
    }
}

#Preview {
    LoadingAnimation {}
}
