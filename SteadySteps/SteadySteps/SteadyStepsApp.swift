import SwiftUI

@main
struct SteadyStepsApp: App {
    @StateObject private var store = WellnessStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .tint(Theme.accent)
        }
    }
}
