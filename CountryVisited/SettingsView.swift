import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var selectedLanguage = Locale.current.language.languageCode?.identifier ?? "en"
    @State private var isClearAllMemoriesAlertPresented = false

    let availableLanguages = [
        ("English", "en"),
        ("Français", "fr"),
        ("Deutsch", "de"),
        ("Italian", "it"),
        ("Spanish", "es")
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("App Settings")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .onChange(of: isDarkMode) { value in
                            setDarkMode(value)
                        }
                        .accessibilityLabel("Toggle dark mode")
                        .accessibilityHint("Switch between dark mode and light mode")
                }

                Section(header: Text("Language Settings")) {
                    Picker("Select Language", selection: $selectedLanguage) {
                        ForEach(availableLanguages, id: \.1) { language in
                            Text(language.0).tag(language.1)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedLanguage) { newValue in
                        changeLanguage(to: newValue)
                    }
                    .accessibilityLabel("Choose language")
                    .accessibilityHint("Select your preferred language")
                }
                
                Section(header: Text("Memories Management")) {
                    Button(action: {
                        isClearAllMemoriesAlertPresented.toggle()
                    }) {
                        Text("Clear All Memories")
                            .foregroundColor(.red)
                    }
                    .accessibilityLabel("Clear all memories")
                    .accessibilityHint("This will delete all stored memories")
                    .alert(isPresented: $isClearAllMemoriesAlertPresented) {
                        Alert(
                            title: Text("Are you sure?"),
                            message: Text("This will delete all stored memories."),
                            primaryButton: .destructive(Text("Clear")) {
                                clearAllMemories()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }

                Section(header: Text("App Information")) {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text("\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown Version")")
                            .foregroundColor(.gray)
                    }
                    .accessibilityLabel("App version information")
                }

                Button(action: {
                    resetPreferences()
                }) {
                    Text("Reset Preferences")
                        .foregroundColor(.red)
                }
                .accessibilityLabel("Reset app preferences")
                .accessibilityHint("This will reset the app settings to their default values")
            }
            .navigationTitle("Settings")
        }
        .onAppear {
            setDarkMode(isDarkMode)
        }
    }

    func setDarkMode(_ isEnabled: Bool) {
        if isEnabled {
            UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = .dark
        } else {
            UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = .light
        }
    }

    func changeLanguage(to languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(0)
    }

    func clearAllMemories() {
        MemoryStore.shared.clearAllMemories()
        NotificationCenter.default.post(name: NSNotification.Name("MemoriesCleared"), object: nil)
    }

    func resetPreferences() {
        UserDefaults.standard.removeObject(forKey: "isDarkMode")
        UserDefaults.standard.removeObject(forKey: "memories")
        setDarkMode(false)
    }
}
