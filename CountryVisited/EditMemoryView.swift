import SwiftUI

struct EditMemoryView: View {
    @Binding var memory: CountryMemory

    @State private var country: String
    @State private var description: String
    @State private var imageData: Data?

    init(memory: Binding<CountryMemory>) {
        _memory = memory
        _country = State(initialValue: memory.wrappedValue.country)
        _description = State(initialValue: memory.wrappedValue.description)
        _imageData = State(initialValue: memory.wrappedValue.imageData)
    }

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Country", text: $country)
                TextField("Description", text: $description)
            }

            Section(header: Text("Photo")) {
                if let imageData = imageData, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("No image selected")
                }
            }

            Button("Save") {
                memory.country = country
                memory.description = description
                memory.imageData = imageData
            }
        }
        .navigationTitle("Edit Memory")
    }
}
