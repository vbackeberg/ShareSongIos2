import SwiftUI

struct WelcomeView: View {
	var body: some View {
		VStack(spacing: 24) {
			Text("Welcome to ShareSong!")
				.font(.system(size: 40, weight: .bold))
				.multilineTextAlignment(.center)
				.padding(.horizontal, 16)
			
			Text("ShareSong let's you open songs from other music services in your own with just two taps. To get started, choose your music service.")
				.font(.system(size: 16))
				.multilineTextAlignment(.center)
				.padding(.horizontal, 16)
			
			NavigationLink(destination: ChooseView()) {
				Text("Choose my music service")
					.font(.system(size: 20, weight: .bold))
					.frame(width: 200, height: 72)
					.background(Color.purple)
					.foregroundColor(.white)
					.cornerRadius(16)
			}
		}
		.frame(maxWidth: 600)
		.padding()
	}
}

#Preview {
	WelcomeView()
}
