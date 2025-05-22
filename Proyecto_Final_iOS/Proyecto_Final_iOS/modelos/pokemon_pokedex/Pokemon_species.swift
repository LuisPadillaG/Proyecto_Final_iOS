//
//  Pokemon_description.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//


struct PokemonSpecies: Codable {
    let flavor_text_entries: [FlavorTextEntry]
    let evolution_chain: EvolutionChainResource
}

struct FlavorTextEntry: Codable {
    let flavor_text: String
    let language: NamedAPIResource
}

struct EvolutionChainResource: Codable {
    let url: String
}
