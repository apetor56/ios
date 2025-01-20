import SwiftUI

struct PaymentFormView: View {
    @Binding var selectedProducts: [Product]
    @State private var name = ""
    @State private var email = ""
    @State private var address = ""
    @State private var isPaymentComplete = false

    var totalPrice: Double {
        selectedProducts.reduce(0) { $0 + $1.price }
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Twoje dane")) {
                    TextField("Imię i nazwisko", text: $name)
                    TextField("Email", text: $email)
                    TextField("Adres", text: $address)
                }

                Section(header: Text("Podsumowanie")) {
                    ForEach(selectedProducts) { product in
                        HStack {
                            Text(product.name)
                            Spacer()
                            Text(String(format: "%.2f zł", product.price))
                        }
                    }
                    HStack {
                        Text("Razem")
                            .bold()
                        Spacer()
                        Text(String(format: "%.2f zł", totalPrice))
                            .bold()
                    }
                }
            }

            Button(action: {
                isPaymentComplete = true
                selectedProducts.removeAll()
            }) {
                Text("Wybór płatności")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(name.isEmpty || email.isEmpty || address.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(name.isEmpty || email.isEmpty || address.isEmpty)
            .padding()

            if isPaymentComplete {
                Text("Płatność zakończona pomyślnie!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .navigationTitle("Formularz płatności")
    }
}
