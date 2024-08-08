import SwiftUI

class GroceryViewModel: ObservableObject {
    @Published var inventory: [GroceryItem] = [] {
        didSet { saveInventory() }
    }
    @Published var shoppingList: [ShoppingItem] = [] {
        didSet { saveShoppingList() }
    }
    
    init() {
        loadInventory()
        loadShoppingList()
    }
    
    // MARK: - Inventory Methods
    func loadInventory() {
        if let data = UserDefaults.standard.data(forKey: "inventory"),
           let savedInventory = try? JSONDecoder().decode([GroceryItem].self, from: data) {
            inventory = savedInventory
        }
    }
    
    func saveInventory() {
        if let encoded = try? JSONEncoder().encode(inventory) {
            UserDefaults.standard.set(encoded, forKey: "inventory")
        }
    }
    
    func addToInventory(_ item: GroceryItem) {
        inventory.append(item)
        scheduleNotificationForItem(item)
    }
    
    func removeFromInventory(at offsets: IndexSet) {
        inventory.remove(atOffsets: offsets)
    }
    
    // MARK: - Shopping List Methods
    func loadShoppingList() {
        if let data = UserDefaults.standard.data(forKey: "shoppingList"),
           let savedList = try? JSONDecoder().decode([ShoppingItem].self, from: data) {
            shoppingList = savedList
        }
    }
    
    func saveShoppingList() {
        if let encoded = try? JSONEncoder().encode(shoppingList) {
            UserDefaults.standard.set(encoded, forKey: "shoppingList")
        }
    }
    
    func addToShoppingList(_ item: ShoppingItem) {
        shoppingList.append(item)
    }
    
    func removeFromShoppingList(at offsets: IndexSet) {
        shoppingList.remove(atOffsets: offsets)
    }
    
    // MARK: - Recipe Methods
    func suggestRecipes() -> [Recipe] {
        let availableIngredients = Set(inventory.map { $0.name.lowercased() })
        return RecipeDatabase.recipes.filter { recipe in
            let recipeIngredients = Set(recipe.ingredients.map { $0.lowercased() })
            return recipeIngredients.isSubset(of: availableIngredients)
        }
    }
    
    // MARK: - Notification Methods
    func scheduleNotificationForItem(_ item: GroceryItem) {
        let content = UNMutableNotificationContent()
        content.title = "Item Expiring Soon"
        content.body = "\(item.name) is expiring on \(itemFormatter.string(from: item.expirationDate))"
        content.sound = UNNotificationSound.default
        
        let expirationDate = item.expirationDate
        let notificationDate = Calendar.current.date(byAdding: .day, value: -1, to: expirationDate)!
        let components = Calendar.current.dateComponents([.year, .month, .day], from: notificationDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: item.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    // MARK: - Utility Properties
    var shoppingListText: String {
        shoppingList.map { "\($0.quantity)x \($0.name)" }.joined(separator: "\n")
    }
}
