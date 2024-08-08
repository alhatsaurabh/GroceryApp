//
//  HelperViews.swift
//  Grocery app
//
//  Created by Saurabh on 08.08.24.
//
import SwiftUI
import Foundation

// MARK: - Helper Views
struct InventoryItemRow: View {
    let item: GroceryItem
    
    var body: some View {
        HStack {
            Image(systemName: iconForCategory(item.category))
                .foregroundColor(colorForCategory(item.category))
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("Expires: \(item.expirationDate, formatter: itemFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text("\(item.quantity)")
                .font(.headline)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .clipShape(Circle())
        }
    }
    
    func iconForCategory(_ category: GroceryItem.Category) -> String {
        switch category {
        case .fruits: return "leaf.fill"
        case .vegetables: return "carrot.fill"
        case .dairy: return "cup.and.saucer.fill"
        case .meat: return "fish.fill"
        case .grains: return "tortoise.fill"
        case .other: return "square.fill"
        }
    }
    
    func colorForCategory(_ category: GroceryItem.Category) -> Color {
        switch category {
        case .fruits: return .green
        case .vegetables: return .orange
        case .dairy: return .blue
        case .meat: return .red
        case .grains: return .yellow
        case .other: return .gray
        }
    }
}

struct ShoppingItemRow: View {
    @Binding var item: ShoppingItem
    
    var body: some View {
        HStack {
            Button(action: { item.isChecked.toggle() }) {
                Image(systemName: item.isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(item.isChecked ? .green : .gray)
            }
            Text(item.name)
            Spacer()
            Text("\(item.quantity)")
                .font(.headline)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .clipShape(Circle())
        }
    }
}
