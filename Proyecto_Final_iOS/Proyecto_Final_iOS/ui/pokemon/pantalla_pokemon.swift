//
//  pantalla_pokemon.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//

import SwiftUI



struct pantalla_pokemon: View {
    @Environment(ControladorAplicacion.self) var controlador
    var id: Int = 1
    let myColorVerdeOscuro = Color(red: 0, green: 0.3, blue: 0, opacity: 0.8) // Color verde oscurito
    let myColorVerdeClaro = Color(red: 0, green: 0.6, blue: 0) // Color verde oscurito
    let myColorWithOpacity = Color(red: 0.8, green: 0.2, blue: 0.1, opacity: 0.7) // Color personalizado con transparencia
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
                                    //Poner barra de navegacion aquio
                                    ZStack{
                                        Rectangle()
                                            .background(myColorVerdeOscuro).foregroundColor(Color.gray.opacity(0))
                                    }.frame(width: 350, height: 225)
                                        .border(Color.white, width: 7)
                                    
                                    Spacer()
                                    VStack{
                                        ScrollView{
                                            ForEach(controlador.pagina_resultados!.results){ pokemon in
                                                HStack{
                                                    Text(pokemon.name).foregroundColor(Color.white).font(.title2)
                                                        .bold()
                                                }.cornerRadius(50)
                                                    .padding(.init(top: 5, leading: 5, bottom: 10, trailing: 0))
                                                    .frame(width: 330)
                                                    .background(myColorVerdeClaro)
                                                    .cornerRadius(10).padding(10)
                                                
                                            }
                                            
                                                
                                        }
                                        
                                    }.background(Color.white)
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
