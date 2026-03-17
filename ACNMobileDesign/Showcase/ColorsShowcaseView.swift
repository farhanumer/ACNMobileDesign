import SwiftUI
import DesignKit

struct ColorsShowcaseView: View {

    @State private var forcedMode: DesignKit.Theme = .system

    private let palette = DesignKitDefaultPalette()

    // All tokens grouped with display name
    private var textTokens: [(String, DesignKitColor)] {[
        ("primaryText",   palette.primaryText),
        ("secondaryText", palette.secondaryText),
        ("tertiaryText",  palette.tertiaryText),
        ("accentText",    palette.accentText),
        ("successText",   palette.successText),
        ("warningText",   palette.warningText),
        ("errorText",     palette.errorText),
        ("infoText",      palette.infoText),
    ]}

    private var backgroundTokens: [(String, DesignKitColor)] {[
        ("primaryBackground",   palette.primaryBackground),
        ("secondaryBackground", palette.secondaryBackground),
        ("tertiaryBackground",  palette.tertiaryBackground),
        ("successBackground",   palette.successBackground),
        ("warningBackground",   palette.warningBackground),
        ("errorBackground",     palette.errorBackground),
        ("infoBackground",      palette.infoBackground),
    ]}

    private var objectTokens: [(String, DesignKitColor)] {[
        ("primaryObject",   palette.primaryObject),
        ("secondaryObject", palette.secondaryObject),
        ("tertiaryObject",  palette.tertiaryObject),
        ("accentObject",    palette.accentObject),
        ("successObject",   palette.successObject),
        ("warningObject",   palette.warningObject),
        ("errorObject",     palette.errorObject),
        ("infoObject",      palette.infoObject),
    ]}

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignKit.sizes.large) {

                // Mode picker
                modePickerSection

                // Token grids
                tokenSection(title: "Text", tokens: textTokens)
                tokenSection(title: "Background", tokens: backgroundTokens)
                tokenSection(title: "Object / UI", tokens: objectTokens)

                // Forced-mode demo
                forcedModeDemo
            }
            .padding(DesignKit.sizes.medium)
        }
        .dkTheme(forcedMode)
        .navigationTitle("Colors")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private var modePickerSection: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Color Scheme Override")
                .font(.dk(.labelLarge))
                .foregroundStyle(.dk(\.secondaryText))

            Picker("Mode", selection: $forcedMode) {
                Text("System").tag(DesignKit.Theme.system)
                Text("Light").tag(DesignKit.Theme.light)
                Text("Dark").tag(DesignKit.Theme.dark)
            }
            .pickerStyle(.segmented)
        }
    }

    private func tokenSection(title: String, tokens: [(String, DesignKitColor)]) -> some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text(title)
                .font(.dk(.headingSmall))
                .foregroundStyle(.dk(\.primaryText))

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: DesignKit.sizes.small)],
                      spacing: DesignKit.sizes.small) {
                ForEach(tokens, id: \.0) { name, token in
                    ColorSwatchView(name: name, token: token)
                }
            }
        }
    }

    private var forcedModeDemo: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Per-Token Mode Lock")
                .font(.dk(.headingSmall))
                .foregroundStyle(.dk(\.primaryText))

            Text("These tokens are locked regardless of the picker above.")
                .font(.dk(.bodySmall))
                .foregroundStyle(.dk(\.secondaryText))

            HStack(spacing: DesignKit.sizes.medium) {
                // Always light
                let alwaysLight = DesignKitColor.hex(light: "#E0F0FF", dark: "#E0F0FF", mode: .light)
                VStack(spacing: DesignKit.sizes.xSmall) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(alwaysLight.color)
                        .frame(height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.3))
                        )
                    Text("Always Light")
                        .font(.dk(.labelSmall))
                        .foregroundStyle(.dk(\.secondaryText))
                }

                // Always dark
                let alwaysDark = DesignKitColor.hex(light: "#1A1A2E", dark: "#1A1A2E", mode: .dark)
                VStack(spacing: DesignKit.sizes.xSmall) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(alwaysDark.color)
                        .frame(height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.3))
                        )
                    Text("Always Dark")
                        .font(.dk(.labelSmall))
                        .foregroundStyle(.dk(\.secondaryText))
                }

                // System adaptive
                let adaptive = DesignKitColor.hex(light: "#F0F0F0", dark: "#2C2C2E")
                VStack(spacing: DesignKit.sizes.xSmall) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(adaptive.color)
                        .frame(height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.3))
                        )
                    Text("System")
                        .font(.dk(.labelSmall))
                        .foregroundStyle(.dk(\.secondaryText))
                }
            }
        }
    }
}

// MARK: - Color swatch cell

private struct ColorSwatchView: View {
    let name: String
    let token: DesignKitColor

    var body: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.xSmall) {
            RoundedRectangle(cornerRadius: 8)
                .fill(token.color)
                .frame(height: 52)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
                )
            Text(name)
                .font(.dk(.labelSmall))
                .foregroundStyle(.dk(\.secondaryText))
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
    }
}

#Preview {
    NavigationStack {
        ColorsShowcaseView()
    }
}
