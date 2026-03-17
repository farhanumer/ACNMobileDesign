import SwiftUI
import DesignKit

struct TypographyShowcaseView: View {

    @State private var selectedFamily: DesignKitFontFamily = .system
    @State private var selectedWeight: DesignKitFontWeight = .regular

    private let sampleText = "The quick brown fox"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignKit.sizes.large) {

                // Family picker
                familyPicker

                // Weight picker
                weightPicker

                // All text styles at selected family
                allStylesSection

                // Family comparison
                familyComparisonSection

                // Custom font note
                customFontSection
            }
            .padding(DesignKit.sizes.medium)
        }
        .navigationTitle("Typography")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private var familyPicker: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Font Family")
                .font(.dk(.labelLarge))
                .foregroundStyle(.dk(\.secondaryText))

            Picker("Family", selection: $selectedFamily) {
                Text("System").tag(DesignKitFontFamily.system)
                Text("Rounded").tag(DesignKitFontFamily.systemRounded)
                Text("Serif").tag(DesignKitFontFamily.systemSerif)
                Text("Mono").tag(DesignKitFontFamily.systemMono)
            }
            .pickerStyle(.segmented)
        }
    }

    private var weightPicker: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Weight Override")
                .font(.dk(.labelLarge))
                .foregroundStyle(.dk(\.secondaryText))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DesignKit.sizes.small) {
                    ForEach(DesignKitFontWeight.allCases, id: \.label) { weight in
                        Button(weight.label) {
                            selectedWeight = weight
                        }
                        .buttonStyle(.bordered)
                        .tint(selectedWeight.label == weight.label ? .accentColor : .secondary)
                        .font(.dk(.labelSmall))
                    }
                }
            }
        }
    }

    private var allStylesSection: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.xSmall) {
            Text("Text Styles")
                .font(.dk(.headingSmall))
                .foregroundStyle(.dk(\.primaryText))

            Divider()

            ForEach(DesignKitTextStyle.allCases, id: \.label) { style in
                VStack(alignment: .leading, spacing: 2) {
                    Text(sampleText)
                        .font(DesignKit.fonts.resolve(style, family: selectedFamily)
                            .weight(selectedWeight.fontWeight))
                        .foregroundStyle(.dk(\.primaryText))
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)

                    Text(styleDescription(for: style))
                        .font(.dk(.labelSmall))
                        .foregroundStyle(.dk(\.tertiaryText))
                }
                .padding(.vertical, 4)

                if style != DesignKitTextStyle.allCases.last {
                    Divider()
                }
            }
        }
    }

    private var familyComparisonSection: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Family Comparison")
                .font(.dk(.headingSmall))
                .foregroundStyle(.dk(\.primaryText))

            let families: [(String, DesignKitFontFamily)] = [
                ("System (SF Pro)", .system),
                ("Rounded (SF Pro Rounded)", .systemRounded),
                ("Serif (New York)", .systemSerif),
                ("Mono (SF Mono)", .systemMono),
            ]

            ForEach(families, id: \.0) { label, family in
                VStack(alignment: .leading, spacing: 2) {
                    Text(sampleText)
                        .font(.dk(.bodyLarge, family: family))
                        .foregroundStyle(.dk(\.primaryText))
                    Text(label)
                        .font(.dk(.labelSmall))
                        .foregroundStyle(.dk(\.tertiaryText))
                }
                .padding(.vertical, DesignKit.sizes.xSmall)

                if label != families.last?.0 {
                    Divider()
                }
            }
        }
    }

    private var customFontSection: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Custom Fonts")
                .font(.dk(.headingSmall))
                .foregroundStyle(.dk(\.primaryText))

            VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
                Text("To use a custom font:")
                    .font(.dk(.bodySmall))
                    .foregroundStyle(.dk(\.secondaryText))

                VStack(alignment: .leading, spacing: 4) {
                    Text("1. Add the .ttf/.otf file to your app target")
                    Text("2. Declare it in Info.plist under UIAppFonts")
                    Text("3. Set the family at launch:")
                }
                .font(.dk(.bodySmall))
                .foregroundStyle(.dk(\.tertiaryText))

                Text("DesignKit.fonts.primaryFamily =\n  .customLoaded(familyName: \"YourFont\")")
                    .font(.dk(.caption, family: .systemMono))
                    .foregroundStyle(.dk(\.primaryText))
                    .padding(DesignKit.sizes.small)
                    .background(.dk(\.secondaryBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(DesignKit.sizes.medium)
            .background(.dk(\.secondaryBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    // MARK: - Helpers

    private func styleDescription(for style: DesignKitTextStyle) -> String {
        switch style {
        case .displayLarge:  return "Display Large · 40 pt · Bold"
        case .displaySmall:  return "Display Small · 32 pt · Semibold"
        case .headingLarge:  return "Heading Large · 24 pt · Bold"
        case .headingMedium: return "Heading Medium · 20 pt · Semibold"
        case .headingSmall:  return "Heading Small · 18 pt · Semibold"
        case .bodyLarge:     return "Body Large · 18 pt · Regular"
        case .bodyMedium:    return "Body Medium · 16 pt · Regular"
        case .bodySmall:     return "Body Small · 14 pt · Regular"
        case .labelLarge:    return "Label Large · 14 pt · Medium"
        case .labelMedium:   return "Label Medium · 12 pt · Medium"
        case .labelSmall:    return "Label Small · 10 pt · Medium"
        case .caption:       return "Caption · 12 pt · Regular"
        }
    }
}

#Preview {
    NavigationStack {
        TypographyShowcaseView()
    }
}
