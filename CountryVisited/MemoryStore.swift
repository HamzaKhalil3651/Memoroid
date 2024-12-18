import Foundation

class MemoryStore {
    static let shared = MemoryStore()

    private let memoryKey = "memories"

    // Save Memories to UserDefaults
    func saveMemories(_ memories: [CountryMemory]) {
        if let encoded = try? JSONEncoder().encode(memories) {
            UserDefaults.standard.set(encoded, forKey: memoryKey)
        }
    }

    // Load Memories from UserDefaults
    func loadMemories() -> [CountryMemory] {
        if let savedMemories = UserDefaults.standard.data(forKey: memoryKey),
           let decoded = try? JSONDecoder().decode([CountryMemory].self, from: savedMemories) {
            return decoded
        }
        return []  // Return an empty array if no memories are saved
    }

    // Clear All Memories from UserDefaults
    func clearAllMemories() {
        UserDefaults.standard.removeObject(forKey: memoryKey)
        print("All memories have been cleared.")
    }
}
