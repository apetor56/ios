import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<CategoryEntity>

    @State private var isShowingAddProductView = false
    @ObservedObject var serverData = ServerData()

    var body: some View {
        NavigationView {
                    List {
                        ForEach(serverData.categories) { category in
                            Section(header: Text(category.name)) {
                                ForEach(serverData.products.filter { $0.category_id == category.id }) { product in
                                    HStack {
                                        Text(product.name)
                                            .font(.headline)
                                        Spacer()
                                        Text("Count: \(product.count)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isShowingAddProductView = true }) {
                        Label("Add Product", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddProductView) {
                AddProductView(isPresented: $isShowingAddProductView)
                    .environment(\.managedObjectContext, viewContext)
            }
            .onAppear {
                createDefaultCategories()
            }
        }
    }

    private func deleteProducts(in category: CategoryEntity, at offsets: IndexSet) {
        withAnimation {
            if let products = category.productRelation as? Set<ProductEntity> {
                let sortedProducts = Array(products).sorted(by: { $0.name ?? "" < $1.name ?? "" })
                offsets.map { sortedProducts[$0] }.forEach { product in
                    category.removeFromProductRelation(product)
                    viewContext.delete(product)
                }
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }

    private func createDefaultCategories() {
        let categoryNames = ["Elektronika", "Książki", "Inne"]
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        do {
            let existingCategories = try viewContext.fetch(fetchRequest)
            for name in categoryNames {
                if !existingCategories.contains(where: { $0.name == name }) {
                    let newCategory = CategoryEntity(context: viewContext)
                    newCategory.name = name
                }
            }
            if viewContext.hasChanges {
                try viewContext.save()
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AddProductView: View {
    @Binding var isPresented: Bool
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<CategoryEntity>

    @State private var name: String = ""
    @State private var count: String = ""
    @State private var selectedCategory: CategoryEntity?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Name", text: $name)
                    TextField("Count", text: $count)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(categories) { category in
                            Text(category.name ?? "Unnamed Category").tag(category as CategoryEntity?)
                        }
                    }
                }
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addProduct()
                        isPresented = false
                    }
                    .disabled(name.isEmpty || count.isEmpty || selectedCategory == nil)
                }
            }
        }
    }

    private func addProduct() {
        withAnimation {
            let newProduct = ProductEntity(context: viewContext)
            newProduct.name = name
            newProduct.count = Int64(count) ?? 0
            selectedCategory?.addToProductRelation(newProduct)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
