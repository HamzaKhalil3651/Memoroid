import SwiftUI

struct MemoryListView: View {
    @State private var memories: [CountryMemory] = []
    @State private var showAddMemoryView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(memories) { memory in
                    PolaroidCardView(memory: memory)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteMemory(memory)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)

                            Button {
                                shareMemory(memory)
                            } label: {
                                Label("Share", systemImage: "square.and.arrow.up")
                            }
                            .tint(.blue)
                        }
                }
            }
            .navigationTitle("Travel Memories")
            .toolbar {
                // Plus Button in Top Right Corner
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddMemoryView.toggle() }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title) // Adjust icon size
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showAddMemoryView) {
                AddMemoryView(memories: $memories)
            }
            .onAppear {
                loadMemories()
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("MemoriesCleared"))) { _ in
                loadMemories() // Reload the memories when they are cleared
            }
        }
    }

    func saveMemories() {
        if let data = try? JSONEncoder().encode(memories) {
            UserDefaults.standard.set(data, forKey: "memories")
        }
    }

    func loadMemories() {
        memories = MemoryStore.shared.loadMemories()
    }

    func deleteMemory(_ memory: CountryMemory) {
        if let index = memories.firstIndex(where: { $0.id == memory.id }) {
            memories.remove(at: index)
            saveMemories()
        }
    }

    func shareMemory(_ memory: CountryMemory) {
        guard let imageData = memory.imageData,
              let image = UIImage(data: imageData) else { return }

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let activityVC = UIActivityViewController(
                activityItems: [image, memory.country, memory.description],
                applicationActivities: nil
            )
            keyWindow.rootViewController?.present(activityVC, animated: true)
        }
    }
}
