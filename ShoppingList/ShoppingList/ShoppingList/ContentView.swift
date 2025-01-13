import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProductEntity.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<ProductEntity>

    @State private var isShowingAddProductView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.name ?? "Unnamed Product")
                                .font(.headline)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Count: \(product.count)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteProducts)
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
        }
    }

    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddProductView: View {
    @Binding var isPresented: Bool
    @Environment(\.managedObjectContext) private var viewContext

    @State private var name: String = ""
    @State private var count: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Name", text: $name)
                    TextField("Count", text: $count)
                        .keyboardType(.numberPad)
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
                    .disabled(name.isEmpty || count.isEmpty)
                }
            }
        }
    }

    private func addProduct() {
        withAnimation {
            let newProduct = ProductEntity(context: viewContext)
            newProduct.name = name
            newProduct.count = Int64(count) ?? 0

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
