//
//  pokemon_detallado.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/16/25.
//

import SwiftUI

struct pantalla_detalle_pokemon: View {
    var idPokemon: Int
    @State private var pokemonCompleto: PocketMonstersCompleto?
    let myColordeFondo = Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1)
    let myColorVerdeClaro = Color(red: 0.01, green: 0.8, blue: 0.2) // Color verde oscurito
    @Environment(ControladorAplicacion.self) var controlador
    var body: some View {
        ScrollView {
            if let pokemon = pokemonCompleto {
                VStack(alignment: .leading, spacing: 20) {
                    ZStack {
                        Ellipse()
                            .fill(Color.red)
                            .frame(width: 525, height: 300)
                            .offset(y: -170)

                        Image("pokeball_background_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .rotationEffect(Angle(degrees: -10))
                            .opacity(0.1)
                            .offset(x: -100, y: -170)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack{
                        if let urlString = pokemon.sprites.front_default,
                           let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 350, height: 350)
                            .padding()
                        }
                        VStack{
                            Text("Datos")
                                .foregroundColor(myColorVerdeClaro)
                                .font(.title).bold().padding(10)
                            Text("Abilities:").frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title3)
                                .bold()
                                .padding(.init(top: 0, leading: 20, bottom: 10, trailing: 0))
                            HStack{
                                ForEach(pokemon.abilities, id: \.ability.name) { habilidad in
                                    HStack{
                                        Text(habilidad.ability.name.capitalized).foregroundColor(myColorVerdeClaro)
                                    }.frame(maxWidth: .infinity, alignment: .leading).padding(.init(top: 0, leading: 20, bottom: 10, trailing: 0))
                                }
                            }
                        }.frame(width: 350).background(Color.white)
                        
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .bold()
                        
                        //Text(pokemon.)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }.offset(y: -400)
                }
                .frame(maxWidth: .infinity) // El VStack ocupa todo el ancho de la pantalla
                .padding()
            } else {
                ProgressView("Cargando información del Pokémon...")
                    .task {
                        await cargarInfo()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.background(myColordeFondo)
        //.navigationTitle("Detalles")
    }

    func cargarInfo() async {
        
        await controlador.cargarPokemonCompleto(id: idPokemon)
        pokemonCompleto = await controlador.pocket_monster_seleccionado
    }


    func extraerEvoluciones(chain: EvolutionChain) -> [String]? {
        var nombres: [String] = []

        func recorrer(_ nodo: EvolutionChain) {
            nombres.append(nodo.species.name)
            nodo.evolves_to.forEach { recorrer($0) }
        }

        recorrer(chain)
        return nombres.isEmpty ? nil : nombres
    }
}
#Preview {
    let controladorDePrueba = ControladorAplicacion()
    return pantalla_detalle_pokemon(idPokemon: 1)
        .environment(controladorDePrueba)
}
