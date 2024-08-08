//
//  ScannerView.swift
//  Grocery app
//
//  Created by Saurabh on 08.08.24.
//
import Foundation
import SwiftUI


// MARK: - ScannerView

struct ScannerView: View {
    @EnvironmentObject private var viewModel: GroceryViewModel
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    
    var body: some View {
        Button(action: { isPresentingScanner = true }) {
            Label("Scan Barcode", systemImage: "barcode.viewfinder")
        }
        .sheet(isPresented: $isPresentingScanner) {
            BarcodeScannerView(scannedCode: $scannedCode, isPresentingScanner: $isPresentingScanner)
        }
        .onChange(of: scannedCode) { oldValue, newValue in
            if let code = newValue {
                handleScannedItem(code)
            }
        }
    }
    
    private func handleScannedItem(_ code: String) {
        // Here you would typically look up the item details using the barcode
        // For this example, we'll just add a placeholder item
        let newItem = GroceryItem(id: UUID(), name: "Scanned Item (\(code))", expirationDate: Date().addingTimeInterval(7*24*60*60), quantity: 1, category: .other)
        viewModel.addToInventory(newItem)
        scannedCode = nil
    }
}
