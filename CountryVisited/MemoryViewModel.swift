import SwiftUI

class MemoryViewModel: ObservableObject {
    @Published var memories: [CountryMemory]

    init() {
        self.memories = MemoryStore.shared.loadMemories()
    }

    func addMemory(_ memory: CountryMemory) {
        memories.append(memory)
        MemoryStore.shared.saveMemories(memories)
        NotificationManager.scheduleMemoryReminder(for: memory) // Schedule notification
    }
}
