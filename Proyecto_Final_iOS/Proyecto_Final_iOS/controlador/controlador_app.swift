//
//  controlador_app.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//

import SwiftUI


@Observable
@MainActor
public class ControladorAplicacion : ObservableObject {
    
    var pagina_resultados: PaginaResultado? = nil
    var personaje: PocketMonstersCompleto? = nil
    
    var pocket_monster_seleccionado: PocketMonstersCompleto? = nil
    
    init(){
        Task.detached(priority: .high){
            await self.descargar_pokemon()
        }
    }
    
    func descargar_pokemon() async {
        print("Funciona por favor, estamos aqui")
        guard let pagina_descargada: PaginaResultado = try? await PokeAPI().descargar_pagina_pokemon() else {return}
        print(pagina_descargada)
        self.pagina_resultados = pagina_descargada
    }
    
    /*func descargar_info_pocket_monster_individual(id: Int) async{
        guard let pocket_monster: PocketMonstersCompleto = try? await PokeAPI().descargar_informacion_pokemon_individual(id: id) else {return}
        
        self.personaje = pocket_monster
    }
    func descargar_informacion_personaje(id: Int){
        Task.detached(operation: {
            await self.descargar_info_pocket_monster_individual(id: id)
        })
    }*/
    
    func cargarPokemonCompleto(id: Int) async {
        if let pokemon = await PokeAPI().descargar_pokemon_completo(id: id) {
            
            self.pocket_monster_seleccionado = pokemon
        } else {
            print("No se pudo cargar el Pokémon completo")
        }
    }
    
    
}
 
