import Foundation

struct PocketMonstersCompleto: Codable {
    let name: String
    let abilities: [AbilityEntry]
    let sprites: Sprites
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
