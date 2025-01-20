//
//  ContentView.swift
//  Oauth
//
//  Created by user270821 on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Logowanie")
                .font(.largeTitle)
                .bold()

            TextField("Nazwa użytkownika", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Hasło", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                login(username: username, password: password)
            }) {
                Text("Zaloguj")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Text(message)
                .foregroundColor(.red)
                .padding()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Wynik logowania"), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }

    func login(username: String, password: String) {
        guard let url = URL(string: "http://127.0.0.1:5000/login") else { return }
        
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]

        guard let body = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    message = "Błąd sieci"
                    showAlert = true
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                        DispatchQueue.main.async {
                            message = responseData["message"] ?? "Zalogowano"
                            showAlert = true
                        }
                    }
                } else {
                    if let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                        DispatchQueue.main.async {
                            message = responseData["message"] ?? "Nieprawidłowy login lub hasło"
                            showAlert = true
                        }
                    }
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

