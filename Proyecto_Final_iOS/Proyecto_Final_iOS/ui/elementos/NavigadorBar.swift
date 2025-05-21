//
//  NavigadorBar.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/21/25.
//

import SwiftUI

struct BarraNavegacion: View {
    var body: some View {
        TabView{
            pantalla_pokemon()
                .tabItem {
                    Label{
                        VStack{
                            Image("pokeball_background_icon")
                            //añadir estilo
                            Text("Pokedex")
                                //.//font(.custom("BungeeTint-Regular", size: 34))
                        }
                    } icon: {
                        Circle()
                            .frame(width: 44, height: 44, alignment: .center)
                            .overlay(Text("Holaaa"))
                    }
                }
        }
    }
}

#Preview {
    BarraNavegacion()
        .environment(ControladorAplicacion())

}
