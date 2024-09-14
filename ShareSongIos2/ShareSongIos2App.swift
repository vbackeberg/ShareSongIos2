import SwiftUI
import SwiftData

@main
struct ShareSongIos2App: App {
    var body: some Scene {
		WindowGroup {
			NavigationView {
				ContentView()
			}
			.navigationViewStyle(.stack)
        }
    }
}

struct ContentView: View {
	@AppStorage("serviceOfUser", store: UserDefaults(suiteName: "group.com.valerian.sharesongios"))
	var selectedService: String = "no service"
	
	var body: some View {
		if (selectedService == "no service") {
			WelcomeView()
		} else {
			ChangeView()
		}
	}
}
