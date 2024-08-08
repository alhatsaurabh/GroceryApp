import Foundation
import SwiftUI
// MARK: - ContentView
struct ContentView: View {
    @EnvironmentObject private var viewModel: GroceryViewModel
    @State private var activeTab = 0
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    
    var body: some View {
        TabView(selection: $activeTab) {
            InventoryView()
                .tabItem {
                    Label("Inventory", systemImage: "list.bullet")
                }
                .tag(0)
            
            ShoppingListView()
                .tabItem {
                    Label("Shopping List", systemImage: "cart")
                }
                .tag(1)
            
            RecipeView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
                .tag(2)
            
            ScannerView()
                .tabItem {
                    Label("Scan", systemImage: "barcode.viewfinder")
                }
                .tag(3)
        }
    }
}
