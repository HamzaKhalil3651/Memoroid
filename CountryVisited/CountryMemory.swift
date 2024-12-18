import Foundation

struct CountryMemory: Identifiable, Codable {
    let id: UUID
    var country: String
    var description: String
    var imageData: Data?
    let date: Date

    // Save Memories to UserDefaults
    static func saveMemories(_ memories: [CountryMemory]) {
        if let data = try? JSONEncoder().encode(memories) {
            UserDefaults.standard.set(data, forKey: "memories")
        }
    }

    // Load Memories from UserDefaults
    static func loadMemories() -> [CountryMemory] {
        guard let data = UserDefaults.standard.data(forKey: "memories"),
              let memories = try? JSONDecoder().decode([CountryMemory].self, from: data) else {
            return []
        }
        return memories
    }
}


