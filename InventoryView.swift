//
//  InventoryView.swift
//  Grocery app
//
//  Created by Saurabh on 08.08.24.
//

import Foundation
import SwiftUI

// MARK: - InventoryView
struct InventoryView: View {
    @EnvironmentObject private var viewModel: GroceryViewModel
    @State private var showingAddItemView = false
    @State private var searchText = ""
    
    var filteredInventory: [GroceryItem] {
        if searchText.isEmpty {
            return viewModel.inventory
        } else {
            return viewModel.inventory.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredInventory) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        InventoryItemRow(item: item)
                    }
                }
                .onDelete(perform: viewModel.removeFromInventory)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("My Groceries")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddItemView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItemView) {
                AddItemView()
            }
        }
        .searchable(text: $searchText, prompt: "Search groceries")
    }
}
