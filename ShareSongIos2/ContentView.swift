import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var responseText: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Sharing songs with others made easy")
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(16)
                .font(.system(size: 24))
            Text("This app can convert links you share from music services to other services, e.g. from Spotify to Deezer. Next time you share a song, look out for the new sharing options.")
                .padding(16)
                .font(.system(size: 16))
            Button(action: { exit(0) }) {
                Text("Cool")
                    .fontWeight(.bold)
                    .font(.system(size: 32))
                    .frame(width: 256, height: 64)
                    .background(Color(UIColor.purple))
                    .foregroundColor(Color(UIColor.white))
                    .cornerRadius(16)
            }
            .padding(.top, 64)
        }
    }
}

#Preview {
    ContentView()
}
