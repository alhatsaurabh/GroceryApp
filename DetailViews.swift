//
//  DetailViews.swift
//  Grocery app
//
//  Created by Saurabh on 08.08.24.
//

import Foundation
import SwiftUI


// MARK: - Detail Views
struct ItemDetailView: View {
    let item: GroceryItem
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: iconForCategory(item.category))
                .font(.system(size: 60))
                .foregroundColor(colorForCategory(item.category))
            Text(item.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            VStack {
                Label("Expires on", systemImage: "calendar")
                Text(item.expirationDate, formatter: itemFormatter)
                    .font(.title2)
            }
            VStack {
                Label("Quantity", systemImage: "number")
                Text("\(item.quantity)")
                    .font(.title2)
            }
            VStack {
                Label("Category", systemImage: "folder")
                Text(item.category.rawValue)
                    .font(.title2)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(item.name, displayMode: .inline)
    }
    
    func iconForCategory(_ category: GroceryItem.Category) -> String {
        InventoryItemRow(item: item).iconForCategory(category)
    }
    
    func colorForCategory(_ category: GroceryItem.Category) -> Color {
        InventoryItemRow(item: item).colorForCategory(category)
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("• " + ingredient)
                    }
                }
                VStack(alignment: .leading) {
                    Text("Instructions")
                        .font(.headline)
                    Text(recipe.instructions)
                }
            }
            .padding()
        }
        .navigationBarTitle(recipe.name, displayMode: .inline)
    }
}
