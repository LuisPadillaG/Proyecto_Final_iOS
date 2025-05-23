//
//  pantalla_pokemon.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//

import SwiftUI



struct pantalla_pokemon: View {
    @Environment(ControladorAplicacion.self) var controlador
    var ide: Int = 1
    let myColorVerdeOscuro = Color(red: 0, green: 0.3, blue: 0, opacity: 0.8) // Color verde oscurito
    let myColorVerdeClaro = Color(red: 0, green: 0.6, blue: 0) // Color verde oscurito
    let myColorGris = Color(red: 0.9, green: 1, blue: 0.95)
    @State private var searchText = ""
    let myColorPantalla = Color(red: 0.33, green: 0.44, blue: 0.25)

    @MainActor private func filteredPokemon() -> [FullDescargadoInfo] {
            if searchText.isEmpty {
                return controlador.pagina_resultados?.results ?? []
            } else {
                return controlador.pagina_resultados?.results.filter {
                    $0.name.lowercased().contains(searchText.lowercased())
                } ?? []
            }
        }
    
    @State private var pokemonSeleccionado: FullDescargadoInfo? = nil
    @State private var mostrarInfo: Bool = false
    @State private var pokemonSpriteURL: String? = nil
    @State private var pokemonNombre: String? = nil


    @MainActor
    func cargarPokemonDemo() async {
        guard let primerPokemon = controlador.pagina_resultados?.results.first,
              let id = obtenerIDDesdeURL(primerPokemon.url) else {
            return
        }

        await controlador.cargarPokemonCompleto(id: id)

        if let detalle = controlador.personaje {
            pokemonSpriteURL = detalle.sprites.front_default
            pokemonNombre = detalle.name.capitalized
        }
    }

    var body: some View {
        if(controlador.pagina_resultados != nil){
            
            NavigationStack {
                            ZStack {
                                Color.red
                                    .ignoresSafeArea()

                                // Imagen de fondo (encima del rojo)
                                Image("pokeball_background_icon")
                                    .resizable()
                                    .scaledToFill()
                                    .opacity(0.2)
                                    .ignoresSafeArea()
                                    .offset(y: -250)
 
                                VStack {
                                    HStack{
                                        Text("P O K E D E X").foregroundColor(Color.white).font(.title2)
                                            .bold()
                                    }.offset(y: 15)
                                    
                                    CustomSearchBar(text: $searchText).offset(y: 20)
                                    /*ZStack{
                                        Rectangle()
                                            .background(myColorVerdeOscuro).foregroundColor(Color.gray.opacity(0))
                                    }.frame(width: 350, height: 225)
                                        .border(myColorGris, width: 7).offset(y: 30)*/
                                    
                                    ZStack {
                                        Rectangle()
                                            .fill(myColorVerdeOscuro)
                                            .frame(width: 350, height: 225)
                                            .border(myColorGris, width: 7)
                                            .offset(y: 30)
                                            .onTapGesture {
                                                mostrarInfo.toggle()
                                                if !mostrarInfo {
                                                    pokemonSpriteURL = nil
                                                    pokemonNombre = nil
                                                    pokemonSeleccionado = nil
                                                }
                                            }
                                        HStack(alignment: .center, content: {
                                            Spacer()
                                            Spacer()
                                            Image("oak_sprite")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 375, height: 200)
                                                .opacity(0.7)
                                                .offset(x: 50, y: 30)
                                            Text("Tap a Pokémon to reveal its information, or learn more about trainers' favorite items")
                                                .foregroundColor(myColorPantalla).font(.headline).offset(x: -150, y: 30).padding(60)
                                            Spacer()
                                        })
                                        
                                    }

                                    
                                    Spacer()

                                    VStack{
                                        ScrollView{
                                            ForEach(Array(filteredPokemon().enumerated()), id: \.element.id) { index, pokemon in
                                                NavigationLink {
                                                    if let idExtraido = obtenerIDDesdeURL(pokemon.url) {
                                                        pantalla_detalle_pokemon(idPokemon: idExtraido)
                                                            .task {
                                                                await controlador.cargarPokemonCompleto(id: idExtraido)
                                                            }
                                                    } else {
                                                        Text("Error al obtener ID")
                                                    }
                                                } label: {
                                                    HStack{
                                                        Text("\(index + 1)").foregroundColor(Color.white).font(.title2).bold()
                                                        Spacer()
                                                        Text(pokemon.name).foregroundColor(Color.white).font(.title2).bold().padding(10)
                                                        Spacer()
                                                    }
                                                    .cornerRadius(50)
                                                    .padding(.init(top: 5, leading: 20, bottom: 10, trailing: 0))
                                                    .frame(width: 330)
                                                    .background(myColorVerdeClaro)
                                                    .cornerRadius(10).padding(10)
                                                }
                                                
                                                .simultaneousGesture(TapGesture().onEnded {
                                                    pokemonSeleccionado = pokemon
                                                    mostrarInfo = true
                                                    Task {
                                                        if let id = obtenerIDDesdeURL(pokemon.url) {
                                                            await controlador.cargarPokemonCompleto(id: id)
                                                            if let detalle = controlador.personaje {
                                                                pokemonSpriteURL = detalle.sprites.front_default
                                                                pokemonNombre = detalle.name.capitalized
                                                            }
                                                        }
                                                    }
                                                })
                                            }


                                        }
                                    }.background(myColorGris)
                                        .cornerRadius(30, corners: [.topLeft, .topRight]).offset(y: 50)

                                }
                                
                            }
                        }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

func obtenerIDDesdeURL(_ url: String) -> Int? {
    let partes = url.split(separator: "/").compactMap { Int($0) }
    return partes.last
}

 
#Preview {
    pantalla_pokemon()
        .environment(ControladorAplicacion())
}
