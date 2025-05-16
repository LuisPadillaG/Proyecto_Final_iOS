//
//  pagina_resultados.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/12/25.
//

import Foundation


/*struct Meta: Codable{
    let totalItems: Int
    let itemCount: Int
    let itemsPerPage: Int
    let totalPages: Int
    let currentPage: Int
}
struct Enlaces: Codable{
    let first: String
    let previous: String
    let next: String
    let last: String
}
 struct PaginaResultado: Codable{ //, Identifiable
     //var id: Int = self.meta.currentPage
     let items: [MonoChino]
     let meta: Meta
     let links: Enlaces
 }*/
struct PaginaResultado: Codable{
    let count: Int
    let next: String?
    let previous: String?
    let results:  [FullDescargadoInfo]
}
