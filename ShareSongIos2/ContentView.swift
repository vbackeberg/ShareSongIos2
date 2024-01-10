import SwiftUI
import SwiftData	

struct ContentView: View {
    @State private var responseText: String = ""
    @State private var showShareSheet = false
    

    var body: some View {
        VStack {
            Text(responseText)
                .padding()
                .border(Color.gray)
            }
            .padding()
            .onOpenURL { url in processUrl(url) }
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(items: [responseText], isPresented: $showShareSheet)
        }
    }

    
    func processUrl(_ url: URL) {
        print(url)
        print(url.absoluteString)
        Task {
            await convertSong(originUrl: "https://deezer.page.link/go6SQsExZhcaw1NM7", targetService: "AppleMusic")
            showShareSheet = true
        }
    }

    
    private func convertSong(originUrl: String, targetService: String) async {
        do {
            let conversionResponse = try await ShareSongApi.convert(originServiceUrl: originUrl, targetService: targetService)
            DispatchQueue.main.async {
                responseText = "Target URL: \(conversionResponse.targetServiceUrl)"
            }
        } catch {
            DispatchQueue.main.async {
                print("Error: \(error)")
                responseText = "Error: \(error.localizedDescription)"
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
