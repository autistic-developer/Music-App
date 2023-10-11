import SwiftUI

struct EdgeFadeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay {
            HStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(.ColorSet.background), .clear]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 15.w)
                Spacer()
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, Color(.ColorSet.background)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 15.w)
            }
            .allowsHitTesting(false)
        }
    }
}

extension View {
    func edgeFade() -> some View {
        self.modifier(EdgeFadeModifier())
    }
}
