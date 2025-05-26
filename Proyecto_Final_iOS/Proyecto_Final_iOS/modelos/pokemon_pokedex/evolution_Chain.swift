//
//  evolution_Chain.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//
//Struct todavía no usada, pensada para añadir al descargado de información a un pokémon detallado
struct evolutionChain:Identifiable, Codable
{
    let id: Int
    let name: String
    let description: String
}
struct EvolutionChainData: Codable {
    let chain: EvolutionChain
}

struct EvolutionChain: Codable {
    let species: NamedAPIResource
    let evolves_to: [EvolutionChain]
}
