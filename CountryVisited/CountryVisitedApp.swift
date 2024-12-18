import SwiftUI

@main
struct CountryVisitedApp: App {
    @StateObject private var memoryViewModel = MemoryViewModel()
    @StateObject private var themeManager = ThemeManager() // Add ThemeManager

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(memoryViewModel) // Pass MemoryViewModel
                .environmentObject(themeManager)    // Pass ThemeManager
        }
    }
}
