import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("backgroundColor") private var backgroundColorHex: String = "#FFFFFF"
    @AppStorage("accentColor") private var accentColorHex: String = "#007AFF"

    @Published var backgroundColor: Color = .white
    @Published var accentColor: Color = .blue

    init() {
        updateTheme() // Set the initial theme when the app is launched
    }

    func updateTheme() {
        if isDarkMode {
            backgroundColor = Color(UIColor(named: "#121212") ?? .black)
            accentColor = Color(UIColor(named: "#BB86FC") ?? .purple)
        } else {
            backgroundColor = Color(UIColor(named: backgroundColorHex) ?? .white)
            accentColor = Color(UIColor(named: accentColorHex) ?? .blue)
        }
    }

    func reset() {
        isDarkMode = false
        backgroundColorHex = "#FFFFFF"
        accentColorHex = "#007AFF"
        updateTheme() // Reset theme to default values
    }
}
