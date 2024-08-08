//
//  RecipeView.swift
//  Grocery app
//
//  Created by Saurabh on 08.08.24.
//
import Foundation
import SwiftUI
// MARK: - RecipeView
struct RecipeView: View {
    @EnvironmentObject private var viewModel: GroceryViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.suggestRecipes()) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    Text(recipe.name)
                }
            }
            .navigationTitle("Suggested Recipes")
        }
    }
}
