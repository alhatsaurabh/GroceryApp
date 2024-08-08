//
//  AddItemViews.swift
//  Grocery app
//
//  Created by Saurabh on 08.08.24.
//
import SwiftUI
import Foundation


// MARK: - Add Item Views
struct AddItemView: View {
    @EnvironmentObject private var viewModel: GroceryViewModel
    @State private var itemName = ""
    @State private var expirationDate = Date()
    @State private var quantity = 1
    @State private var category: GroceryItem.Category = .other
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Item Name", text: $itemName)
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 1...100)
                    Picker("Category", selection: $category) {
                        ForEach(GroceryItem.Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
                Section(header: Text("Expiration")) {
                    DatePicker("Expiration Date", selection: $expirationDate, displayedComponents: .date)
                }
            }
            .navigationBarTitle("Add New Item", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newItem = GroceryItem(id: UUID(), name: itemName, expirationDate: expirationDate, quantity: quantity, category: category)
                                               viewModel.addToInventory(newItem)
                                               presentationMode.wrappedValue.dismiss()
                                           }
                                           .disabled(itemName.isEmpty)
                                       }
                                       ToolbarItem(placement: .cancellationAction) {
                                           Button("Cancel") {
                                               presentationMode.wrappedValue.dismiss()
                                           }
                                       }
                                   }
                               }
                           }
                       }

                       struct AddShoppingItemView: View {
                           @EnvironmentObject private var viewModel: GroceryViewModel
                           @State private var itemName = ""
                           @State private var quantity = 1
                           @Environment(\.presentationMode) var presentationMode
                           
                           var body: some View {
                               NavigationView {
                                   Form {
                                       TextField("Item Name", text: $itemName)
                                       Stepper("Quantity: \(quantity)", value: $quantity, in: 1...100)
                                   }
                                   .navigationBarTitle("Add to Shopping List", displayMode: .inline)
                                   .toolbar {
                                       ToolbarItem(placement: .confirmationAction) {
                                           Button("Add") {
                                               let newItem = ShoppingItem(id: UUID(), name: itemName, quantity: quantity, isChecked: false)
                                               viewModel.addToShoppingList(newItem)
                                               presentationMode.wrappedValue.dismiss()
                                           }
                                           .disabled(itemName.isEmpty)
                                       }
                                       ToolbarItem(placement: .cancellationAction) {
                                           Button("Cancel") {
                                               presentationMode.wrappedValue.dismiss()
                                           }
                                       }
                                   }
                               }
                           }
                       }

                     
