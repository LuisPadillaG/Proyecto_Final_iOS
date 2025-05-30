//
//  pantalla_objeto_detallado.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/22/25.
//

import SwiftUI

struct pantalla_objeto_detallado: View {
    let nombreObjeto: String
    let myColorVerdeClaro = Color(red: 0, green: 0.6, blue: 0, opacity: 0.8) // Color verde oscurito
    let myColordeFondo = Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1)

    @State private var objeto: ObjetosCompletos?
    
    var body: some View {
        ZStack{
            Ellipse()
                .fill(Color.red)
                .frame(width: 525, height: 300)
                .offset(y: -420)

            Image("pokeball_background_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: -10))
                .opacity(0.1)
                .offset(x: -100, y: -400)
            ScrollView {
                if let objeto = objeto {
                    VStack() {
                        if let url = objeto.sprites.defaultImage, let imageURL = URL(string: url) {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 250)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        Text(objeto.name.capitalized)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(myColorVerdeClaro)
                        

                        if let efecto = objeto.effectEntries.first(where: { $0.language.name == "es" }) ?? objeto.effectEntries.first {
                                    VStack(){
                                        Text("Effect:")
                                            .font(.title2)
                                            .foregroundColor(myColorVerdeClaro)
                                            .bold().padding()
                                        Text(efecto.shortEffect)
                                            .font(.callout).padding()
                                            .foregroundColor(myColorVerdeClaro)
                                        Text("Description:")
                                            .font(.title2).padding().bold()
                                            .foregroundColor(myColorVerdeClaro)
                                        Text(efecto.effect).padding(10)
                                            .font(.callout)
                                            .foregroundColor(myColorVerdeClaro)
                                            .padding(5)
                                            
                                        
                                    }.frame(width: 350).background(Color.gray.opacity(0.05))
                            
                                .cornerRadius(10).offset(y: 0)
                                    .padding()
                                } else {
                                    Text("No hay descripción disponible.")
                                        .foregroundStyle(.gray)
                                }
                    }
                    .padding()
                } else {
                    ProgressView("Cargando objeto...")
                }
            }
            .onAppear {
                Task {
                    await cargarObjeto()
                }
            }
        }
        
    }

    func cargarObjeto() async {
        objeto = await PokeAPI().descargar_objeto_individual(nombre: nombreObjeto)
    }
}

#Preview {
    pantalla_objeto_detallado(nombreObjeto: "ultra-ball")
}
