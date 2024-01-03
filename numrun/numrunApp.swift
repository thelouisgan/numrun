//
//  numrunApp.swift
//  numrun
//
//  Created by Louis Gan on 24/12/2023.
//

import SwiftUI
import FirebaseCore

@main
struct numrunApp: App {
    // register app delegate for Firebase setup
    init () {
        FirebaseApp.configure()
    }

    var body: some Scene {

        WindowGroup {
            ContentView()
        }
    }
}
