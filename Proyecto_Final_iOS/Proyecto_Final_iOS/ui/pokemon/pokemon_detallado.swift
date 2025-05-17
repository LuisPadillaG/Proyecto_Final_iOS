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

    @Environment(ControladorAplicacion.self) var controlador
    var body: some View {
        ScrollView {
            if let pokemon = pokemonCompleto {
                VStack(alignment: .leading, spacing: 20) {
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .bold()

                    if let urlString = pokemon.sprites.front_default,
                       let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 150)
                        .padding()
                    }

                    Text("Habilidades:")
                        .font(.title3)
                        .bold()
                    ForEach(pokemon.abilities, id: \.ability.name) { habilidad in
                        Text(habilidad.ability.name.capitalized)
                    }
                }
                .padding()
            } else {
                ProgressView("Cargando información del Pokémon...")
                    .task {
                        await cargarInfo()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("Detalles")
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
