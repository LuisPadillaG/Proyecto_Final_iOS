//
//  ContentView.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            pantalla_pokemon()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}
