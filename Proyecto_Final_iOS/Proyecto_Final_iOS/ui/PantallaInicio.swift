//
//  PantallaInicio.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/22/25.
//

import SwiftUI

struct PantallaInicio: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Image("Fondo_pokedex")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.7)
                VStack{
                    Image("Logo_pokedex")
                    Text("Guía básica para entrenadores primerisos")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    NavigationLink(destination: BarraNavegacion(), label: {
                        Text("¡Vamos alla!")
                    })
                }
            }
        }
    }
}

#Preview {
    PantallaInicio()
        .environmentObject(ControladorAplicacion())
}
