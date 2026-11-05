import SwiftUI

enum Theme {
    static let accent = Color(red: 0.22, green: 0.55, blue: 0.47)
    static let pale = Color(red: 0.90, green: 0.96, blue: 0.93)
}

struct SectionCard<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        VStack(alignment: .leading, spacing: 12) { content }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18))
    }
}

struct SafetyBanner: View {
    var body: some View {
        Label {
            Text("If you feel dizzy or faint, stop, sit somewhere safe, and do not push through symptoms. Seek medical advice for ongoing dizziness.")
                .font(.subheadline)
        } icon: { Image(systemName: "cross.case.fill") }
        .foregroundStyle(.primary)
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.orange.opacity(0.13), in: RoundedRectangle(cornerRadius: 16))
        .accessibilityElement(children: .combine)
    }
}
