//
//  ContentView.swift
//  ACNMobileDesign
//
//  Created by muhammad.farhan.umer on 3/16/26.
//

import SwiftUI
import DesignKit

struct ContentView: View {
    @Binding var colorSchemePreference: ColorScheme?

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: ColorsShowcaseView()) {
                        Label("Colors", systemImage: "paintpalette")
                    }
                    NavigationLink(destination: TypographyShowcaseView()) {
                        Label("Typography", systemImage: "textformat")
                    }
                    NavigationLink(destination: SizingShowcaseView()) {
                        Label("Sizing & Spacing", systemImage: "ruler")
                    }
                    NavigationLink(destination: ExtensionsShowcaseView()) {
                        Label("Extensions", systemImage: "puzzlepiece.extension")
                    }
                } header: {
                    Text("Design Tokens")
                        .font(.dk(.labelMedium))
                }
            }
            .navigationTitle("DesignKit")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ColorSchemePicker(preference: $colorSchemePreference)
                }
            }
        }
    }
}

/// A three-state picker: system / light / dark, displayed as a segmented control icon button.
struct ColorSchemePicker: View {
    @Binding var preference: ColorScheme?
    @Environment(\.colorScheme) private var current

    var body: some View {
        Menu {
            Button {
                preference = nil
            } label: {
                Label("System", systemImage: preference == nil ? "checkmark" : "circle")
            }
            Button {
                preference = .light
            } label: {
                Label("Light", systemImage: preference == .light ? "checkmark" : "sun.max")
            }
            Button {
                preference = .dark
            } label: {
                Label("Dark", systemImage: preference == .dark ? "checkmark" : "moon")
            }
        } label: {
            Image(systemName: iconName)
                .symbolRenderingMode(.hierarchical)
        }
    }

    private var iconName: String {
        switch preference {
        case .light:  return "sun.max.fill"
        case .dark:   return "moon.fill"
        default:      return current == .dark ? "moon.circle" : "sun.max.circle"
        }
    }
}

#Preview {
    ContentView(colorSchemePreference: .constant(nil))
}
