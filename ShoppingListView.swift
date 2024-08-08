//
//  ShoppingListView.swift
//  Grocery app
//
//  Created by Saurabh on 08.08.24.
//
import Foundation
import SwiftUI
// MARK: - ShoppingListView
struct ShoppingListView: View {
    @EnvironmentObject private var viewModel: GroceryViewModel
    @State private var showingAddItemView = false
    @State private var isShowingShareSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach($viewModel.shoppingList) { $item in
                    ShoppingItemRow(item: $item)
                }
                .onDelete(perform: viewModel.removeFromShoppingList)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Shopping List")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddItemView = true }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingShareSheet = true }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .sheet(isPresented: $showingAddItemView) {
                AddShoppingItemView()
            }
            .sheet(isPresented: $isShowingShareSheet) {
                ShareSheet(activityItems: [viewModel.shoppingListText])
            }
        }
    }
}

