import SwiftUI

struct ChangeView: View {
	@AppStorage("serviceOfUser", store: UserDefaults(suiteName: "group.com.valerian.sharesongios"))
	var selectedService: String = "no service"
	
	var body: some View {
		VStack(spacing: 24) {
			Text("Your selected music service is \(serviceNames[selectedService] ?? "no service").")
				.font(.system(size: 40, weight: .bold))
				.multilineTextAlignment(.center)
				.padding(.horizontal, 16)
			
			Text("If someone sends you a link to a song, tap and hold on it to open the sharing menu. Tap on 'Convert with ShareSong' to open the song in \(serviceNames[selectedService] ?? "your music service").")
				.font(.system(size: 16))
				.multilineTextAlignment(.center)
				.padding(.horizontal, 16)
			
			NavigationLink(destination: ChooseView()) {
				Text("Change Service")
					.font(.system(size: 20, weight: .bold))
					.frame(width: 200, height: 50)
					.background(Color.purple)
					.foregroundColor(.white)
					.cornerRadius(10)
			}
		}
		.padding()
	}
}

#Preview {
	ChangeView()
}
