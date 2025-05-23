//
//  controlador_app_items.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/22/25.
//

import Foundation
import Observation

@Observable
class ControladorObjetos {
    var objetos: [FullDescargadoInfoObjetos] = []

    func cargarObjetos() async {
        if let resultado = await PokeAPI().descargar_objetos() {
            self.objetos = resultado.results
        }
    }
}

