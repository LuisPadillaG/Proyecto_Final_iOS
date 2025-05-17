//
//  evolution_Chain.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//

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
