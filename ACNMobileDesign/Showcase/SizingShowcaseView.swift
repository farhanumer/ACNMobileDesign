import SwiftUI
import DesignKit

struct SizingShowcaseView: View {

    @State private var baseUnit: CGFloat = 8
    @State private var customMultiplier: String = "2"

    private var computedValue: CGFloat {
        let multiplier = Double(customMultiplier) ?? 1
        return DesignKit.sizes.custom(multiplier: CGFloat(multiplier))
    }

    private let horizontalTokens: [(String, Double)] = [
        ("xxSmall",    0.25),
        ("xSmall",     0.5),
        ("small",      1.0),
        ("mediumSmall",1.5),
        ("medium",     2.0),
        ("large",      3.0),
        ("xLarge",     4.0),
        ("xxLarge",    6.0),
        ("giant",      8.0),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignKit.sizes.large) {

                // Base unit stepper
                baseUnitSection

                // Custom multiplier calculator
                calculatorSection

                // Spacing tokens
                spacingTokensSection

                // Text sizes
                textSizesSection
            }
            .padding(DesignKit.sizes.medium)
        }
        .navigationTitle("Sizing")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private var baseUnitSection: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Base Unit")
                .font(.dk(.headingSmall))
                .foregroundStyle(.dk(\.primaryText))

            HStack {
                Text("Current base: \(Int(baseUnit)) pt")
                    .font(.dk(.bodyMedium))
                    .foregroundStyle(.dk(\.primaryText))

                Spacer()

                Stepper("", value: $baseUnit, in: 4...24, step: 2)
                    .labelsHidden()
                    .onChange(of: baseUnit) { _, newValue in
                        DesignKit.sizes.baseUnit = newValue
                    }
            }

            Text("All spacing tokens below recompute automatically when this changes.")
                .font(.dk(.caption))
                .foregroundStyle(.dk(\.tertiaryText))
        }
    }

    private var calculatorSection: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Multiplier Calculator")
                .font(.dk(.headingSmall))
                .foregroundStyle(.dk(\.primaryText))

            HStack(spacing: DesignKit.sizes.medium) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Multiplier")
                        .font(.dk(.labelSmall))
                        .foregroundStyle(.dk(\.secondaryText))
                    TextField("e.g. 2.5", text: $customMultiplier)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                }

                Image(systemName: "multiply")
                    .foregroundStyle(.dk(\.tertiaryText))

                VStack(alignment: .leading, spacing: 4) {
                    Text("Base (\(Int(baseUnit)) pt)")
                        .font(.dk(.labelSmall))
                        .foregroundStyle(.dk(\.secondaryText))
                    Text("\(Int(baseUnit)) pt")
                        .font(.dk(.bodyMedium))
                        .foregroundStyle(.dk(\.primaryText))
                        .frame(width: 60)
                }

                Image(systemName: "equal")
                    .foregroundStyle(.dk(\.tertiaryText))

                VStack(alignment: .leading, spacing: 4) {
                    Text("Result")
                        .font(.dk(.labelSmall))
                        .foregroundStyle(.dk(\.secondaryText))
                    Text("\(String(format: "%.1f", computedValue)) pt")
                        .font(.dk(.bodyMedium, family: .systemMono))
                        .foregroundStyle(.dk(\.accentText))
                }
            }
            .padding(DesignKit.sizes.medium)
            .background(.dk(\.secondaryBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Common multiplier examples
            VStack(alignment: .leading, spacing: DesignKit.sizes.xSmall) {
                Text("Examples at \(Int(baseUnit)) pt base:")
                    .font(.dk(.labelMedium))
                    .foregroundStyle(.dk(\.secondaryText))

                let examples: [(String, CGFloat)] = [
                    ("0.5×", 0.5), ("1×", 1), ("2×", 2), ("3×", 3),
                    ("4×", 4), ("6×", 6), ("20×", 20), ("20.25×", 20.25)
                ]
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 8)], spacing: 8) {
                    ForEach(examples, id: \.0) { label, multiplier in
                        VStack(spacing: 2) {
                            Text(label)
                                .font(.dk(.labelSmall))
                                .foregroundStyle(.dk(\.secondaryText))
                            Text("\(String(format: "%.1f", DesignKit.sizes.custom(multiplier: multiplier))) pt")
                                .font(.dk(.labelMedium, family: .systemMono))
                                .foregroundStyle(.dk(\.primaryText))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(.dk(\.secondaryBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
    }

    private var spacingTokensSection: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Spacing Tokens")
                .font(.dk(.headingSmall))
                .foregroundStyle(.dk(\.primaryText))

            Text("Horizontal & Vertical (same scale)")
                .font(.dk(.caption))
                .foregroundStyle(.dk(\.tertiaryText))

            ForEach(horizontalTokens, id: \.0) { name, multiplier in
                let value = DesignKit.sizes.custom(multiplier: CGFloat(multiplier))
                let displayWidth = min(value, 280)

                HStack(spacing: DesignKit.sizes.medium) {
                    Text(name)
                        .font(.dk(.labelSmall, family: .systemMono))
                        .foregroundStyle(.dk(\.secondaryText))
                        .frame(width: 88, alignment: .leading)

                    Rectangle()
                        .fill(Color.dk(\.accentObject))
                        .frame(width: displayWidth, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 4))

                    Text("\(String(format: "%.0f", value)) pt")
                        .font(.dk(.labelSmall, family: .systemMono))
                        .foregroundStyle(.dk(\.tertiaryText))
                }
            }
        }
    }

    private var textSizesSection: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {
            Text("Text Sizes")
                .font(.dk(.headingSmall))
                .foregroundStyle(.dk(\.primaryText))

            ForEach(DesignKitTextSize.allCases, id: \.rawValue) { size in
                HStack(alignment: .center) {
                    Text("Aa")
                        .font(.system(size: size.rawValue))
                        .foregroundStyle(.dk(\.primaryText))
                        .frame(minWidth: 60, alignment: .leading)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(sizeName(for: size))
                            .font(.dk(.labelMedium))
                            .foregroundStyle(.dk(\.primaryText))
                        Text("\(Int(size.rawValue)) pt")
                            .font(.dk(.labelSmall, family: .systemMono))
                            .foregroundStyle(.dk(\.tertiaryText))
                    }
                }
                .padding(.vertical, 4)

                if size != DesignKitTextSize.allCases.last {
                    Divider()
                }
            }
        }
    }

    // MARK: - Helpers

    private func sizeName(for size: DesignKitTextSize) -> String {
        switch size {
        case .xxSmall: return "xxSmall"
        case .xSmall:  return "xSmall"
        case .small:   return "small"
        case .body:    return "body"
        case .medium:  return "medium"
        case .large:   return "large"
        case .xLarge:  return "xLarge"
        case .xxLarge: return "xxLarge"
        case .display: return "display"
        }
    }
}

#Preview {
    NavigationStack {
        SizingShowcaseView()
    }
}
