import SwiftUI

struct MemoryCardView: View {
    let memory: CountryMemory

    var body: some View {
        VStack(alignment: .leading) {
            if let imageData = memory.imageData, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
            }
            Text(memory.country)
                .font(.headline)
                .padding(.top, 8)
            Text(memory.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

