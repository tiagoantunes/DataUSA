//
//  DataUSAApp.swift
//  DataUSA
//
//  Created by Tiago Antunes on 13/10/2024.
//

import SwiftUI

@main
struct DataUSAApp: App {
    @StateObject private var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                appCoordinator.view(page: .home)
                    .navigationDestination(
                        for: Page.self
                    ) { destination in
                        appCoordinator.view(page: destination)
                    }
            }
            .environmentObject(appCoordinator)
        }
    }
}
