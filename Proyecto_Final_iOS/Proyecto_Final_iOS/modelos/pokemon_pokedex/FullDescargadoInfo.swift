//
//  FullDescargadoInfo.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/14/25.
//
import Foundation



struct FullDescargadoInfo: Codable, Identifiable{
    let id = UUID()
        //Full Descargado de Info ya tiene el nombre y la url, lo cual es la cosa casi más inutil del multiverso, pero hey. Tenemos cositas.
        let name: String
        let url: String
}
