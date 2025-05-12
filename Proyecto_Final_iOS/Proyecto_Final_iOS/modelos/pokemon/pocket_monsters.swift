//
//  pocket_monsters.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//


struct PocketMonsters: Identifiable, Codable{
        //pocketMonster es como MonoChino.
        let id: String
        let name: String
        let abilities: [String]
        let sprite: String //sprites.front_default o sprites.other.dream_world
         
    
        let description: String //este se encuentra en pokemon-species/
        let evolutionChain: [String]//este se encuentra en evolution-chain/
    
        //let originPlanet: Planeta?
    
        //let transformations: Array<Transformacion>?
    
}
