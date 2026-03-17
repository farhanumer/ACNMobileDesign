import SwiftUI
import DesignKit

struct ExtensionsShowcaseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignKit.sizes.large) {
                colorExtensionSection
                fontExtensionSection
                dkTextStyleSection
                dkPaddingSection
                dkThemeSection
            }
            .padding(DesignKit.sizes.medium)
        }
        .navigationTitle("Extensions")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Color.dk()

    private var colorExtensionSection: some View {
        ShowcaseSectionView(
            title: "Color.dk(\\.token)",
            subtitle: "Shorthand to read any palette token as a SwiftUI Color."
        ) {
            CodeExampleView(code: """
Text("Primary")
    .foregroundStyle(.dk(\\.primaryText))

Rectangle()
    .fill(.dk(\\.accentObject))

view.background(.dk(\\.secondaryBackground))
""")

            VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
                HStack {
                    Text("foregroundStyle")
                        .font(.dk(.labelMedium))
                        .foregroundStyle(.dk(\.primaryText))
                    Spacer()
                    Text("primaryText")
                        .font(.dk(.labelSmall, family: .systemMono))
                        .foregroundStyle(.dk(\.tertiaryText))
                }
                HStack {
                    Text("foregroundStyle")
                        .font(.dk(.labelMedium))
                        .foregroundStyle(.dk(\.secondaryText))
                    Spacer()
                    Text("secondaryText")
                        .font(.dk(.labelSmall, family: .systemMono))
                        .foregroundStyle(.dk(\.tertiaryText))
                }
                HStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.dk(\.accentObject))
                        .frame(width: 60, height: 28)
                    Spacer()
                    Text(".fill(.accentObject)")
                        .font(.dk(.labelSmall, family: .systemMono))
                        .foregroundStyle(.dk(\.tertiaryText))
                }
                HStack {
                    Text("Padded view")
                        .font(.dk(.labelMedium))
                        .foregroundStyle(.dk(\.primaryText))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.dk(\.successBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Spacer()
                    Text(".background(.successBackground)")
                        .font(.dk(.labelSmall, family: .systemMono))
                        .foregroundStyle(.dk(\.tertiaryText))
                }
            }
        }
    }

    // MARK: - Font.dk()

    private var fontExtensionSection: some View {
        ShowcaseSectionView(
            title: "Font.dk(.style)",
            subtitle: "Shorthand to resolve a semantic text style to a SwiftUI Font."
        ) {
            CodeExampleView(code: """
Text("Title")
    .font(.dk(.headingLarge))

Text("Body")
    .font(.dk(.bodyMedium))

// Override font family for one call
Text("Rounded")
    .font(.dk(.bodyMedium, family: .systemRounded))
""")

            VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
                ForEach([
                    (DesignKitTextStyle.headingLarge,  DesignKitFontFamily.system,       "headingLarge · system"),
                    (DesignKitTextStyle.bodyMedium,    DesignKitFontFamily.system,       "bodyMedium · system"),
                    (DesignKitTextStyle.bodyMedium,    DesignKitFontFamily.systemRounded,"bodyMedium · rounded"),
                    (DesignKitTextStyle.bodyMedium,    DesignKitFontFamily.systemSerif,  "bodyMedium · serif"),
                    (DesignKitTextStyle.labelSmall,    DesignKitFontFamily.systemMono,   "labelSmall · mono"),
                ], id: \.2) { style, family, label in
                    HStack {
                        Text("The quick brown fox")
                            .font(.dk(style, family: family))
                            .foregroundStyle(.dk(\.primaryText))
                        Spacer()
                        Text(label)
                            .font(.dk(.labelSmall, family: .systemMono))
                            .foregroundStyle(.dk(\.tertiaryText))
                    }
                }
            }
        }
    }

    // MARK: - .dkTextStyle()

    private var dkTextStyleSection: some View {
        ShowcaseSectionView(
            title: ".dkTextStyle(.style, color:)",
            subtitle: "Applies font + foreground color in a single modifier."
        ) {
            CodeExampleView(code: """
// Font only
Text("Heading")
    .dkTextStyle(.headingMedium)

// Font + color token
Text("Subheading")
    .dkTextStyle(.bodyMedium, color: \\.secondaryText)

// Font + color + family override
Text("Custom")
    .dkTextStyle(.bodySmall,
                 color: \\.tertiaryText,
                 family: .systemSerif)
""")

            VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
                Text("Heading — font only")
                    .dkTextStyle(.headingMedium)

                Text("Subheading — font + secondaryText")
                    .dkTextStyle(.bodyMedium, color: \.secondaryText)

                Text("Small serif — font + tertiaryText + serif family")
                    .dkTextStyle(.bodySmall, color: \.tertiaryText, family: .systemSerif)

                Text("Label + error color")
                    .dkTextStyle(.labelLarge, color: \.errorText)

                Text("Caption + success color")
                    .dkTextStyle(.caption, color: \.successText)
            }
        }
    }

    // MARK: - .dkPadding()

    private var dkPaddingSection: some View {
        ShowcaseSectionView(
            title: ".dkPadding(horizontal:vertical:)",
            subtitle: "Applies horizontal and vertical padding using spacing token values."
        ) {
            CodeExampleView(code: """
CardView()
    .dkPadding(horizontal: .medium, vertical: .small)
""")

            VStack(spacing: DesignKit.sizes.small) {
                ForEach([
                    ("xxSmall / xxSmall", DesignKit.sizes.Token.xxSmall, DesignKit.sizes.Token.xxSmall),
                    ("small / xSmall",    DesignKit.sizes.Token.small,   DesignKit.sizes.Token.xSmall),
                    ("medium / small",    DesignKit.sizes.Token.medium,  DesignKit.sizes.Token.small),
                    ("large / medium",    DesignKit.sizes.Token.large,   DesignKit.sizes.Token.medium),
                ], id: \.0) { label, h, v in
                    Text(label)
                        .font(.dk(.labelMedium, family: .systemMono))
                        .foregroundStyle(.dk(\.primaryText))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .dkPadding(horizontal: h, vertical: v)
                        .background(.dk(\.accentObject).opacity(0.15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.dk(\.accentObject).opacity(0.4), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
        }
    }

    // MARK: - .dkTheme()

    private var dkThemeSection: some View {
        ShowcaseSectionView(
            title: ".dkTheme(.mode)",
            subtitle: "Forces an entire view subtree to light, dark, or system mode — independent of the device setting."
        ) {
            CodeExampleView(code: """
// Always light, even on a device in dark mode
CardView()
    .dkTheme(.light)

// Always dark
BannerView()
    .dkTheme(.dark)

// Follow the device
ContentView()
    .dkTheme(.system)
""")

            HStack(spacing: DesignKit.sizes.medium) {
                ForEach([
                    ("System",      DesignKit.Theme.system),
                    ("Light",       DesignKit.Theme.light),
                    ("Dark",        DesignKit.Theme.dark),
                ], id: \.0) { label, mode in
                    VStack(spacing: DesignKit.sizes.xSmall) {
                        VStack(alignment: .leading, spacing: 6) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.dk(\.primaryBackground))
                                .frame(height: 10)
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.dk(\.secondaryBackground))
                                .frame(height: 8)
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.dk(\.accentObject))
                                .frame(height: 8).frame(maxWidth: .infinity * 0.6)
                        }
                        .padding(10)
                        .background(.dk(\.primaryBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                        )
                        .dkTheme(mode)

                        Text(label)
                            .font(.dk(.labelSmall))
                            .foregroundStyle(.dk(\.secondaryText))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

// MARK: - Reusable sub-components

private struct ShowcaseSectionView<Content: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.dk(.headingSmall, family: .systemMono))
                    .foregroundStyle(.dk(\.primaryText))
                Text(subtitle)
                    .font(.dk(.bodySmall))
                    .foregroundStyle(.dk(\.secondaryText))
            }
            content
        }
        .padding(DesignKit.sizes.medium)
        .background(.dk(\.secondaryBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

private struct CodeExampleView: View {
    let code: String

    var body: some View {
        Text(code)
            .font(.dk(.labelSmall, family: .systemMono))
            .foregroundStyle(.dk(\.primaryText))
            .padding(DesignKit.sizes.small)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.dk(\.tertiaryBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    NavigationStack {
        ExtensionsShowcaseView()
    }
}
