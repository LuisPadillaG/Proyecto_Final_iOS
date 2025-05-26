//
//  pagina_resultados_2.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/22/25.
//

import Foundation
//resultados generales de la api apenas entras a items
struct PaginaResultadoObjetos: Codable{
    let count: Int
    let next: String?
    let previous: String?
    let results:  [FullDescargadoInfoObjetos]
}

