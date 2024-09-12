import SwiftUI

struct ChangeView: View {
    @AppStorage("serviceOfUser", store: UserDefaults(suiteName: "group.com.valerian.sharesongios"))
    var selectedService: String = "no"

    var body: some View {
        VStack(spacing: 24) {
            Text("You have selected \(selectedService).")
                .font(.system(size: 40, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            NavigationLink(destination: ContentView()) {
                Text("Change Service")
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 200, height: 50)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ChangeView()
}
