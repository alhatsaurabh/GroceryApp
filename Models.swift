import Foundation
import SwiftUI

// MARK: - Data Models
struct GroceryItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var expirationDate: Date
    var quantity: Int
    var category: Category
    
    enum Category: String, CaseIterable, Codable {
        case fruits = "Fruits"
        case vegetables = "Vegetables"
        case dairy = "Dairy"
        case meat = "Meat"
        case grains = "Grains"
        case other = "Other"
    }
}

struct ShoppingItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var quantity: Int
    var isChecked: Bool
}

struct Recipe: Identifiable {
    let id: UUID
    var name: String
    var ingredients: [String]
    var instructions: String
    var difficulty: Int // 1 (easy) to 5 (hard)
}

// MARK: - Recipe Database
struct RecipeDatabase {
    static let recipes: [Recipe] = [
        Recipe(id: UUID(), name: "Fruit Salad", ingredients: ["apple", "banana", "orange"], instructions: "Chop fruits and mix.", difficulty: 1),
        Recipe(id: UUID(), name: "Vegetable Stir Fry", ingredients: ["carrot", "broccoli", "bell pepper"], instructions: "Chop vegetables and stir fry.", difficulty: 2),
        // Add more recipes here
    ]
}

// MARK: - Formatters
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
