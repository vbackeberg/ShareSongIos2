import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var responseText: String = ""
    
    @State private var originServiceUrl: String = ""
    @State private var showConversion: = false
    enum Service: String, CaseIterable, Identifiable {
        case Spotify, AppleMusic, YoutubeMusic, Deezer, Tidal
        var id: Self { self }
    }
    @State private var selectedService: Service = Service.AppleMusic

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

            TextField("Enter a song link", text: $originServiceUrl)
            List {
                Picker("Choose music service", selection: $selectedService) {
                    Text("Spotify").tag(Service.Spotify)
                    Text("Apple Music").tag(Service.AppleMusic)
                    Text("Youtube Music").tag(Service.YoutubeMusic)
                    Text("Deezer").tag(Service.Deezer)
                    Text("Tidal").tag(Service.Tidal)
                }
            }
            
            Button() {
                showConversion = true
            }.sheet(isPresented: $showConversion) {
                ConversionViewController(originServiceUrl, targetServiceName=selectedService.rawValue)
            }
            
            Spacer()
        }
    }
    
    struct ConversionViewController: UIViewControllerRepresentable {
        let originServiceUrl: String
        let targetServiceName: String
        
        func makeUIViewController(context: Context) -> BaseActionViewController {
            let baseActionViewController = BaseActionViewController()
            baseActionViewController.targetServiceName = targetServiceName
            baseActionViewController.
            
            return baseActionViewController
        }

        func updateUIViewController(_ uiViewController: BaseActionViewController, context: Context) {
            code
        }
    }
}

#Preview {
    ContentView()
}
