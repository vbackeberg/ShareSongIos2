import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Welcome to ShareSong")
                .font(.system(size: 40, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Text("This app let's you open songs from other music services in your own. To get started choose your music service. You can change it at any time later.")
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            NavigationLink(destination: ContentView()) {
                Text("Choose my music service")
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 200, height: 72)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
        }
        .padding()
    }
}

#Preview {
    WelcomeView()
}
