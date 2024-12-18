import SwiftUI

struct PolaroidCardView: View {
    var memory: CountryMemory
    
    // Formatter for the date
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // or use .long, .short based on preference
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 15) {
            // Image Section
            if let imageData = memory.imageData, let uiImage = UIImage(data: imageData) {
                ZStack {
                    // Add colorful background with Polaroid-like effect
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.random(), Color.random()]),
                            startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: 270, height: 270)
                        .shadow(radius: 10)
                        .accessibilityLabel("Polaroid-style memory background")

                    // The image itself
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        .accessibilityLabel("Memory image")
                        .accessibilityHint("Image of the memory for \(memory.country)")
                }
            }

            // Text Section: Country, Description, and Date
            VStack(alignment: .center, spacing: 8) {
                Text(memory.country)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)  // Dark text for contrast
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("Country: \(memory.country)")

                Text(memory.description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .truncationMode(.tail)
                    .accessibilityLabel("Description: \(memory.description)")
                    .accessibilityHint("Description of the memory in \(memory.country)")

                // Date Section
                Text("Visited on: \(dateFormatter.string(from: memory.date))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                    .accessibilityLabel("Visit date: \(dateFormatter.string(from: memory.date))")
            }
            .padding([.leading, .trailing], 16)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.white)  // Ensure white background outside of the image border
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(10)
    }
}
