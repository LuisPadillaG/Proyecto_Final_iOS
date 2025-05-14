//
//  pantalla_pokemon.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//

import SwiftUI

struct pantalla_pokemon: View {
    @Environment(ControladorAplicacion.self) var controlador
    var body: some View {
        if(controlador.pagina_resultados != nil){
            
            NavigationStack {
                            ZStack {
                                // Fondo rojo
                                Color.red
                                    .ignoresSafeArea()

                                // Imagen de fondo (encima del rojo)
                                Image("pokeball_background_icon")
                                    .resizable()
                                    .scaledToFill()
                                    .opacity(0.2) // Opcional: le bajas opacidad si quieres un efecto sutil
                                    .ignoresSafeArea()
                                    .offset(y: -250)
 
                                VStack {
                                    //Rectangle()
                                    Text("Medio paso llevamos")
                                        .foregroundColor(.white)
                                        //.font(.title)
                                        .bold()
                                }
                            }
                        }
        }
    }
}

#Preview {
    pantalla_pokemon()
        .environment(ControladorAplicacion())
}
