import Foundation

struct PocketMonstersCompleto: Codable {
    let name: String
    let abilities: [AbilityEntry]
    let sprites: Sprites
    let types: [TypeEntry] 
    var description: String?
    var evoluciones: [String]?
}

struct AbilityEntry: Codable {
    let ability: NamedAPIResource
}

struct NamedAPIResource: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    let front_default: String?
}

struct TypeEntry: Codable {
    let slot: Int
    let type: NamedAPIResource
}
