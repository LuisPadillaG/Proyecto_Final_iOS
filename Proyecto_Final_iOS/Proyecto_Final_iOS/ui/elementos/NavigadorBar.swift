//
//  NavigadorBar.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/21/25.
//

import SwiftUI

struct BarraNavegacion: View {
    init() {
            //Cambia el fondo
            UITabBar.appearance().backgroundColor = UIColor.systemGray6
        }
    var body: some View {
        TabView {
            pantalla_pokemon()
                .tabItem {
                    VStack(spacing: 2) {
                        Image(systemName: "circle.bottomhalf.filled.inverse")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("Pokedex")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                }

            pantalla_objeto()
                .tabItem {
                    VStack(spacing: 2) {
                        Image(systemName: "book.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text("Objetos")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                }
        }
        .tint(.green)


    }
}

#Preview {
    BarraNavegacion()
        .environment(ControladorAplicacion())

}
