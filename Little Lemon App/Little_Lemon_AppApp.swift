import SwiftUI

@main
struct Little_LemonApp: App {
    var body: some Scene {
        WindowGroup {
            Onboarding()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
