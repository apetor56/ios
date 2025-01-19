//
//  ServerData.swift
//  ShoppingList
//
//  Created by user270821 on 1/19/25.
//

import SwiftUI
import Combine
import Foundation

struct Product: Decodable, Identifiable {
    var id: Int
    var name: String
    var desc: String?
    var price: Double
    var count: Int
    var category_id: Int
}

struct Category: Decodable, Identifiable {
    var id: Int
    var name: String
}

class ServerData: ObservableObject {
    @Published var products = [Product]()
    @Published var categories = [Category]()
    
    init() {
        fetchCategories()
        fetchProducts()
    }
    
    private func fetchCategories() {
        guard let url = URL(string: "http://127.0.0.1:5000/api/categories") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedCategories = try JSONDecoder().decode([Category].self, from: data)
                    DispatchQueue.main.async {
                        self.categories = decodedCategories
                    }
                } catch {
                    print("Failed to decode categories: \(error)")
                }
            }
        }.resume()
    }
    
    private func fetchProducts() {
        guard let url = URL(string: "http://127.0.0.1:5000/api/products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedProducts = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        self.products = decodedProducts
                    }
                } catch {
                    print("Failed to decode products: \(error)")
                }
            }
        }.resume()
    }
}
