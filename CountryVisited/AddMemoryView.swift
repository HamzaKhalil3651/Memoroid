import SwiftUI

struct AddMemoryView: View {
    @State private var countryName = ""
    @State private var countryDescription = ""
    @State private var selectedDate = Date()
    @State private var selectedImage: UIImage? = nil

    @Binding var memories: [CountryMemory]
    
    // Use environment dismiss to dismiss the view
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                TextField("Country Name", text: $countryName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .accessibilityLabel("Enter the country name")
                    .accessibilityHint("Type the name of the country you visited")

                TextField("Description", text: $countryDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .accessibilityLabel("Enter a description of the memory")
                    .accessibilityHint("Describe your visit to the country")

                DatePicker("Date of Visit", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                    .accessibilityLabel("Select the date you visited the country")

                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                        .accessibilityLabel("Image of the country")
                        .accessibilityHint("Picture of the country you visited")
                }

                ImagePicker(selectedImage: $selectedImage)
                    .accessibilityLabel("Choose an image for your memory")
                    .accessibilityHint("Pick a photo from your library to represent this memory")

                Spacer()

                Button("Save") {
                    guard !countryName.isEmpty else { return }
                    let newMemory = CountryMemory(
                        id: UUID(),
                        country: countryName,
                        description: countryDescription,
                        imageData: selectedImage?.jpegData(compressionQuality: 1.0),
                        date: selectedDate
                    )
                    memories.append(newMemory)
                    // Save memories using MemoryStore
                    MemoryStore.shared.saveMemories(memories)
                    dismiss() // Dismiss the view after saving the memory
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.bottom)
                .accessibilityLabel("Save memory")
                .accessibilityHint("Tap to save this memory")
            }
            .navigationTitle("Add Memory")
            .background(Color.white.edgesIgnoringSafeArea(.all)) // Clean white background
        }
    }
}
