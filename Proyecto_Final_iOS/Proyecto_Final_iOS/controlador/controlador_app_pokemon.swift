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
     
    
    func cargarPokemonCompleto(id: Int) async {
        if let pokemon = await PokeAPI().descargar_pokemon_completo(id: id) {
            
            self.pocket_monster_seleccionado = pokemon
        } else {
            print("No se pudo cargar el Pokémon completo")
        }
    }
    
    
}
 
