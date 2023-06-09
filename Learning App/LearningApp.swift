//
//  Learning_AppApp.swift
//  Learning App
//
//  Created by Andrew Koo on 6/8/23.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
