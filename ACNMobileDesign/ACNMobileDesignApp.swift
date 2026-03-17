//
//  ACNMobileDesignApp.swift
//  ACNMobileDesign
//
//  Created by muhammad.farhan.umer on 3/16/26.
//

import SwiftUI

@main
struct ACNMobileDesignApp: App {
    @State private var colorSchemePreference: ColorScheme? = nil

    var body: some Scene {
        WindowGroup {
            ContentView(colorSchemePreference: $colorSchemePreference)
                .preferredColorScheme(colorSchemePreference)
        }
    }
}
