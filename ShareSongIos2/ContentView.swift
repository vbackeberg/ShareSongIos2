import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var responseText: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("Sharing songs with others made easy 🎵")
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
                .font(.system(size: 24))
            Text("This app lets you convert links from one music service to another. Give it a try! Click the share button below and look for the options in the list.")
                .padding()
                .font(.system(size: 16))

            SongView().padding()
            Spacer()
        }
    }
}

struct SongView: View {
    var body: some View {
        HStack {
            // Song cover
            Image("SharePreview")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .shadow(radius: 8)

            // Song details and share button
            VStack(alignment: .leading) {
                Text("Cruel Summer")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Taylor Swift")
                    .font(.subheadline)
                    .foregroundColor(.white)

                Spacer()

                HStack {
                    Spacer()

                    Button {
                        let AV = UIActivityViewController(activityItems:
                            [URL(string: "https://open.spotify.com/intl-de/track/1BxfuPKGuaTgP7aM0Bbdwr?si=01f6a5dcfed240b8")!],
                            applicationActivities: nil)
                        let activeScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
                        let rootViewController = (activeScene?.windows ?? []).first(where: { $0.isKeyWindow })?.rootViewController
                        // for iPad. if condition is optional.
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            AV.popoverPresentationController?.sourceView = rootViewController?.view
                            AV.popoverPresentationController?.sourceRect = .zero
                        }
                        rootViewController?.present(AV, animated: true, completion: nil)

                    } label: {
                        Image(systemName: "square.and.arrow.up").foregroundColor(.white).font(.system(size: 32)).frame(width: 40, height: 40)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color(red: 180 / 255, green: 142 / 255, blue: 173 / 255))
        .cornerRadius(16)
        .frame(height: 120)
    }
}

#Preview {
    ContentView()
}
