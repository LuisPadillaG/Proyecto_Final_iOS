//
//  Objeto_Individual.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/22/25.
//
import Foundation


//Esta es toda la información individual para el descargado de cada objeto, no le muevas porfa. (Al menos aquí no tengo que entrar a otras subcategorías de la API
struct ObjetosCompletos: Codable {
    let name: String
    let effectEntries: [EffectEntry]
    let sprites: SpritesObject

    enum CodingKeys: String, CodingKey {
        case name
        case effectEntries = "effect_entries"
        case sprites
    }
}

struct EffectEntry: Codable {
    let effect: String
    let shortEffect: String
    let language: Language

    enum CodingKeys: String, CodingKey {
        case effect
        case shortEffect = "short_effect"
        case language
    }
}

struct Language: Codable {
    let name: String
}

struct SpritesObject: Codable {
    let defaultImage: String?

    enum CodingKeys: String, CodingKey {
        case defaultImage = "default"
    }
}


 
