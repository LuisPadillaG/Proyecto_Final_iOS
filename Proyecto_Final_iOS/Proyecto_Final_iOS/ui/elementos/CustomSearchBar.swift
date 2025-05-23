//
//  CustomSearchBar.swift
//  Proyecto_Final_iOS
//
//  Created by alumno on 5/16/25.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String

    var body: some View {
        let myColorVerdeOscuro = Color(red: 0, green: 0.4, blue: 0.4, opacity: 0.8)
        HStack {
            TextField("Search", text: $text)
                .padding(.leading, 15)
                .padding(.vertical, 12) .foregroundColor(.white)
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.trailing, 15)
        }
        .background(myColorVerdeOscuro)
        .frame(width: 350, height: 45) .border(Color.blue, width: 3)
    }
} 
