import SwiftUI

struct MainView: View {
    @State private var showAddMemoryView = false
    @State private var memories: [CountryMemory] = []

    var body: some View {
        NavigationView {
            ZStack {
                // Memory List Section
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
                .listStyle(PlainListStyle()) // Remove any default background

                // Add Button Section
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showAddMemoryView.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Circle().fill(Color.blue)) // Full blue circle
                                .shadow(radius: 5) // Soft shadow for button
                        }
                        .padding()
                        .accessibilityLabel("Add Memory")
                    }
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all)) // Clean white background
            .navigationTitle("Travel Memories")
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView()) {
                Image(systemName: "gear")
                    .font(.title)
                    .foregroundColor(.blue)
            })
            .sheet(isPresented: $showAddMemoryView) {
                AddMemoryView(memories: $memories)
            }
            .onAppear {
                loadMemories()
            }
        }
    }

    func saveMemories() {
        if let data = try? JSONEncoder().encode(memories) {
            UserDefaults.standard.set(data, forKey: "memories")
        }
    }

    func loadMemories() {
        if let data = UserDefaults.standard.data(forKey: "memories"),
           let savedMemories = try? JSONDecoder().decode([CountryMemory].self, from: data) {
            memories = savedMemories
        }
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
