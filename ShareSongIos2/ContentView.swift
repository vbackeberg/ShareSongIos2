//
//  ContentView.swift
//  ShareSongIos2
//
//  Created by user935487 on 1/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var responseText: String = ""
    @State private var showShareSheet = false
    @State private var itemsToShare: [Any] = ["This is a test string"]

    var body: some View {

    }

    var body: some View {
        VStack {
            Text(responseText)
                .padding()
                .border(Color.gray)
                    Button("Share") {
                        Task {
                                await convertSong(originUrl: "https://deezer.page.link/go6SQsExZhcaw1NM7", targetService: "AppleMusic")
                            }
                        showShareSheet = true
                    }
                .sheet(isPresented: $showShareSheet) {
                    ShareSheet(items: itemsToShare, isPresented: $showShareSheet)
                }
        }
        .padding()
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
