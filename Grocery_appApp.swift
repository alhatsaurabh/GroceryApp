//
//  Grocery_appApp.swift
//  Grocery app
//
//  Created by Saurabh on 07.08.24.
//

import SwiftUI

// MARK: - Main App Structure
@main
struct Grocery_appApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var viewModel = GroceryViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
