//
//  ContentView.swift
//  TaskList
//
//  Created by user252223 on 1/4/25.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct ContentView: View {
    @State private var tasks = [
        Task(title: "Kup mleko", description: "Pamiętaj, aby kupić mleko w drodze do domu."),
        Task(title: "Zrób ćwiczenia", description: "30 minut jogi."),
        Task(title: "Przeczytaj książkę", description: "Rozdział 5 nowej książki."),
    ]

    var body: some View {
        NavigationView {
            List(tasks) { task in
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Lista Zadań")
        }
    }
}

#Preview {
    ContentView()
}

