import SwiftUI

struct ChooseView: View {
	@AppStorage("serviceOfUser", store: UserDefaults(suiteName: "group.com.valerian.sharesongios"))
	var selectedService: String = "no service"
	
	@State private var newServiceSelected = false
		
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
		ScrollView {
			VStack(alignment: .center, spacing: 16) {
				Text("Select your music service")
					.font(.system(size: 40, weight: .bold))
					.multilineTextAlignment(.center)
					.padding(.horizontal, 16)
				
				Spacer()
				
				LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
					ForEach(serviceNames.keys.sorted(), id: \.self) { key in
						ButtonWithOutline(
							text: serviceNames[key]!,
							isSelected: key == selectedService,
							onSelected: {
								selectedService = key
								dismiss()
							}
						)
					}
				}
				.padding(.horizontal, 16)
			}
			.padding(.top, 48)
		}
		.background(Color(uiColor: .systemBackground))
		.edgesIgnoringSafeArea(.bottom)
		
		NavigationLink(destination: ChangeView(), isActive: $newServiceSelected) { EmptyView()}
	}

}

struct ButtonWithOutline: View {
	let text: String
	let isSelected: Bool
	let onSelected: () -> Void
	
	var body: some View {
		Button(action: {
			onSelected()
		}) {
			Text(text)
				.font(.system(size: 20))
				.frame(width: 128, height: 96)
				.background(isSelected ? Color.purple : Color.gray.opacity(0.3))
				.cornerRadius(16)
				.foregroundColor(isSelected ? Color.white : Color.primary)
				.padding(8)
				.multilineTextAlignment(.center)
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		ChooseView()
	}
}
