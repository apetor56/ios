import SwiftUI

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
}

struct Product: Codable, Identifiable {
    let id: Int
    let name: String
    let category_id: Int
    let price: Double
}

struct ContentView: View {
    @State private var categories: [Category] = []
    @State private var products: [Product] = []
    @State private var selectedProducts: [Product] = []
    @State private var showPaymentForm = false

    var totalPrice: Double {
        selectedProducts.reduce(0) { $0 + $1.price }
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(categories) { category in
                        Section(header: Text(category.name)) {
                            ForEach(products.filter { $0.category_id == category.id }) { product in
                                HStack {
                                    Text(product.name)
                                    Spacer()
                                    Text(String(format: "%.2f zł", product.price))
                                    if selectedProducts.contains(where: { $0.id == product.id }) {
                                        Button(action: {
                                            if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
                                                selectedProducts.remove(at: index)
                                            }
                                        }) {
                                            Text("Usuń")
                                                .foregroundColor(.red)
                                        }
                                    } else {
                                        Button(action: {
                                            selectedProducts.append(product)
                                        }) {
                                            Text("Dodaj")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: fetchData)
                
                Text("Łączna cena: \(String(format: "%.2f zł", totalPrice))")
                    .font(.headline)
                    .padding()

                NavigationLink(destination: PaymentFormView(selectedProducts: $selectedProducts), isActive: $showPaymentForm) {
                    EmptyView()
                }
                Button(action: {
                    showPaymentForm = true
                }) {
                    Text("Przejdź do płatności")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedProducts.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(selectedProducts.isEmpty)
                .padding()
            }
            .navigationTitle("Produkty")
        }
    }

    func fetchData() {
        let group = DispatchGroup()
        group.enter()
        fetchCategories {
            group.leave()
        }
        group.enter()
        fetchProducts {
            group.leave()
        }
        group.notify(queue: .main) {}
    }

    func fetchCategories(completion: @escaping () -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/categories") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let decoded = try? JSONDecoder().decode([Category].self, from: data) {
                DispatchQueue.main.async {
                    self.categories = decoded
                    completion()
                }
            }
        }.resume()
    }

    func fetchProducts(completion: @escaping () -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/products") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let decoded = try? JSONDecoder().decode([Product].self, from: data) {
                DispatchQueue.main.async {
                    self.products = decoded
                    completion()
                }
            }
        }.resume()
    }
}
