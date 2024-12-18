import SwiftUI

struct MemoryDetailView: View {
    var memory: CountryMemory

    var body: some View {
        VStack {
            if let imageData = memory.imageData,
               let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .foregroundColor(.gray)
            }

            Text(memory.country)
                .font(.title)
                .padding()

            Text(memory.description)
                .padding()

            Spacer()
        }
        .padding()
        .navigationTitle(memory.country)
    }
}
