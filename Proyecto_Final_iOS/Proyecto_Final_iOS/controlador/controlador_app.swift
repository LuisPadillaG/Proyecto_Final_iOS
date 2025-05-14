//
//  controlador_app.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//

import SwiftUI


@Observable
@MainActor
public class ControladorAplicacion {
    var pocket_monster_seleccionado: PocketMonsters? = nil
    
    var pagina_resultados: PaginaResultado? = nil
    var personaje: PocketMonsters? = nil
    
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
    
    func descargar_info_pocket_monster_individual(id: Int) async{
        guard let pocket_monster: PocketMonsters = try? await PokeAPI().descargar_informacion_pokemon_individual(id: id) else {return}
        
        self.personaje = pocket_monster
    }
    func descargar_informacion_personaje(id: Int){
        Task.detached(operation: {
            await self.descargar_info_pocket_monster_individual(id: id)
        })
    }
    
    
}
 
