import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
       //Gradient(colors: [Color("LightBlue"), Color("PeachOrange")])
            
        )
    }
}
