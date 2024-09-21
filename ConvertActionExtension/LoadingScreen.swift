import SwiftUI

struct LoadingScreen: View {
	@AppStorage("serviceOfUser", store: UserDefaults(suiteName: "group.com.valerian.sharesongios"))
	var selectedService: String = "no service"
	
    var close: () -> Void

    var body: some View {
        VStack {
            HStack {
                Spacer()
                CloseButton { close() }.frame(width: 32, height: 32).padding()
            }

            Spacer()
			Text("Looking for your song on \(serviceNames[selectedService] ?? "your music service")").font(.system(size: 16)).padding()
            LoadingAnimation(close: close)
            Spacer()
        }
    }
}

#Preview {
    LoadingScreen {}
}

/// A native close button wrapped as a SwiftUI element
/// See: https://stackoverflow.com/a/73629513/13249319
struct CloseButton: UIViewRepresentable {
    private let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .close)
        button.addTarget(context.coordinator, action: #selector(Coordinator.perform), for: .primaryActionTriggered)
        return button
    }

    func updateUIView(_ uiView: UIButton, context: Context) {
        context.coordinator.action = action
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }

    class Coordinator {
        var action: () -> Void

        init(action: @escaping () -> Void) {
            self.action = action
        }

        @objc func perform() {
            action()
        }
    }
}
