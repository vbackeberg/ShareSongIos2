import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var responseText: String = ""

    body: some View {
        VStack {
            Text(responseText)
                .padding()
                .border(Color.gray)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
