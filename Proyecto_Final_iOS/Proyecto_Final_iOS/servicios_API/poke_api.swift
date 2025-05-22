//
//  poke_api.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//

import SwiftUI

struct PokeAPI: Codable {
    var url_base = "https://pokeapi.co/api/v2/"
    func descargar_objetos() async -> PaginaResultadoObjetos?{
        let ubicacion_recursos = "item/"
        return await descargar(recurso: ubicacion_recursos)
    }
    //descargar_pagina_personajes
    //"inspirado en servicios_API/dragonball_api"
    func descargar_pagina_pokemon() async -> PaginaResultado?{
        let ubicacion_recursos = "pokemon/"
        
        return await descargar(recurso: ubicacion_recursos)
    }
    
    /*func descargar_informacion_pokemon_individual(id: Int) async -> PocketMonstersCompleto?{
        let ubicacion_recurso = "pokemon/\(id)"
        return await descargar(recurso: ubicacion_recurso)
    }*/
    func descargar_informacion_evolutionChain(id: Int) async -> evolutionChain?{
        let ubicacion_recurso = "evolution-chain/\(id)"  //No hace nada
        return await descargar(recurso: ubicacion_recurso)
    }
    func descargar_informacion_pokemonSpecies(id: Int) async -> evolutionChain?{
        let ubicacion_recurso = "pokemon-species/\(id)" //No hace nada
        return await descargar(recurso: ubicacion_recurso)
    }  
    
    private func descargar<TipoGenerico: Codable>(recurso: String) async -> TipoGenerico?{
        do{
            guard let url = URL(string: "\(url_base)\(recurso)") else { throw ErroresDeRed.malaDireccionUrl}
            let (datos, respuesta) = try await URLSession.shared.data(from: url)
            guard let respuesta = respuesta as? HTTPURLResponse else { throw ErroresDeRed.badResponse}
            guard respuesta.statusCode >= 200 && respuesta.statusCode < 300 else { throw ErroresDeRed.badStatus}
            do{
                let respuesta_decodificada = try JSONDecoder().decode(TipoGenerico.self, from: datos)
                        
                return respuesta_decodificada
            }
            catch let error as NSError{
                if let stringData = String(data: datos, encoding: .utf8) {
                        print("Respuesta cruda:\n\(stringData)")
                    }
                    print("El error en tu modelo ES \(error.debugDescription) ")
                    throw ErroresDeRed.fallaAlConvertirLaRespuesta
            }
            
            
        } catch ErroresDeRed.malaDireccionUrl {
            print("Tienes mal la url, cambiala")
        }
        catch ErroresDeRed.badResponse {
            print("Algo salió mal con la respuesta, revisa porfas")
        }
        catch ErroresDeRed.badStatus {
            print("Como conseguiste un status de algo que ni se mueve? wtf")
            
        }
        catch ErroresDeRed.fallaAlConvertirLaRespuesta {
            print("Tienes mal el modelo o la implementación de este")
            print("en dragon ball api")
        }
        catch ErroresDeRed.invalidRequest{
            print("Literal quien sabe comom hiciste este error man, neta")
        }
        catch{
            print("Algo terriblemente mal que no se que es, paso. No deberia pasar eso")
        }
        return nil
    }
    
    func extraerEvoluciones(chain: EvolutionChain) -> [String] {
        var nombres: [String] = []

        func recorrer(_ nodo: EvolutionChain) {
            nombres.append(nodo.species.name)
            nodo.evolves_to.forEach { recorrer($0) }
        }

        recorrer(chain)
        return nombres
    }
    func descargar_pokemon_completo(id: Int) async -> PocketMonstersCompleto? {
        do {
            //1. Descargar datos básicos de Pokémon
            guard var pokemon: PocketMonstersCompleto = await descargar(recurso: "pokemon/\(id)/") else {
                print("Error al descargar datos del Pokémon básico")
                return nil
            }

            //2. Descargar species para obtener descripción y URL cadena evolutiva
            guard let species: PokemonSpecies = await descargar(recurso: "pokemon-species/\(id)/") else {
                print("Error al descargar species")
                return nil
            }

            //3. Obtener descripción en español (o texto por defecto)
            let descripcion = species.flavor_text_entries.first(where: { $0.language.name == "es" })?.flavor_text
                .replacingOccurrences(of: "\n", with: " ") ?? "Sin descripción."
            pokemon.description = descripcion
            //Aquí agregamos la propiedad descripción a PocketMonstersCompleto (puedes usar extensión o modificar modelo)
            //pokemon.description = descripcion
            //Pero si no está en el modelo, puedes hacer un struct con una propiedad extra, o guardarla aparte
            //Por simplicidad aquí nada más lo imprimimos
            print("Descripción:", descripcion)
            print("Tipos:", pokemon.types.map { $0.type.name })

            // 4. Descargar cadena evolutiva
            guard let urlCadenaEvo = URL(string: species.evolution_chain.url) else {
                        print("Error creando URL de cadena evolutiva")
                        return nil
            }

            let (dataEvo, _) = try await URLSession.shared.data(from: urlCadenaEvo)
            let evolutionChain = try JSONDecoder().decode(EvolutionChainData.self, from: dataEvo)

            let nombresEvoluciones = extraerEvoluciones(chain: evolutionChain.chain)
            pokemon.evoluciones = nombresEvoluciones
            // Si quieres, puedes agregar la cadena evolutiva a Pokémon (igual que con descripción)
            // pokemon.evolutionChain = evolutionChain
            if let primeraEvolucion = evolutionChain.chain.evolves_to.first?.species.name {
                // Aquí tienes el nombre de la primera evolución
                print("Primera evolución: \(primeraEvolucion)")
                
                guard let datosEvolucion: PocketMonstersCompleto = await descargar(recurso: "pokemon/\(primeraEvolucion)/") else {
                    print("No se pudo obtener el Pokémon de la evolución")
                    return pokemon
                }

                //Se descarga la información de pokémon con el nombre
            }
            

            
            // Aquí retornamos solo el pokemon básico para que compile
            return pokemon

        } catch {
            print("Error al descargar el Pokémon completo: \(error)")
            return nil
        }
    }

    
}
 
