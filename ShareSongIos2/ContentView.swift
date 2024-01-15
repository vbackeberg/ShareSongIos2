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
    }
}


#Preview {
    ContentView()
}
