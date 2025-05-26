//
//  FullDescargadoInfoObjetos.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/22/25.
//
import Foundation
//Esto es lo que te da items de forma inicial para todos los objects
struct FullDescargadoInfoObjetos: Codable, Identifiable{
    let id = UUID()
        //Full Descargado de Info ya tiene el nombre y la url, lo cual es la cosa casi más inutil del multiverso, pero hey. Tenemos cositas.
        let name: String
        let url: String
}
