//
//  musicApp.swift
//  music
//
//  Created by Nitya Addanki on 1/30/25.
//

import SwiftUI

@main
struct musicApp: App {
    @State private var appdata = AppData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appdata)
        }
    }
}
