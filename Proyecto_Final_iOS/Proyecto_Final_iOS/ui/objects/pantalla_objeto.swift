//
//  pantalla_objeto.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/22/25.
//

import SwiftUI

struct pantalla_objeto: View {
    @State private var controlador: ControladorObjetos? = nil
    let myColorVerdeClaro = Color(red: 0, green: 0.6, blue: 0, opacity: 0.8) // Color verde oscurito
    let myColorBlancoPseudoTransparente = Color(red: 1, green: 1, blue: 1, opacity: 0.9)
    var body: some View {
        
        NavigationView {
            
            if let controlador = controlador {
                
                List(controlador.objetos) { objeto in
                    NavigationLink(destination: pantalla_objeto_detallado(nombreObjeto: objeto.name)) {
                        Text(objeto.name.capitalized)
                            .font(.title3) .bold()
                            .foregroundStyle(myColorVerdeClaro) //Color del texto de la fila
                            .padding(.vertical, 5) //Espaciado vertical dentro de la fila
                    }
                    .listRowBackground(myColorBlancoPseudoTransparente) // Fondo de cada fila
                    .listRowSeparatorTint(.green) // Color del separador
                    .listRowSeparator(.visible, edges: .all) // Asegura que el separador sea visible
                    .padding(20)
                }
                .listStyle(.plain)
                .background(Color.red.ignoresSafeArea())
                .navigationTitle("Objetos")
                .toolbarBackground(.red, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                
            } else {
                ProgressView("Cargando objetos...")
                    .task {
                        let nuevoControlador = ControladorObjetos()
                        await nuevoControlador.cargarObjetos()
                        controlador = nuevoControlador
                    }
            }
        }
    }
}

#Preview {
    pantalla_objeto()
}
