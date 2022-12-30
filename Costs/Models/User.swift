//
//  User.swift
//  costs
//
//  Created by Dávid Godzsák on 30/11/2022.
//
import SwiftUI

struct User : Identifiable {
    let id: UUID = UUID()
    let name: String
    let pin: String
}

extension User {
    static let sampleData: [User] = [
        User(name: "Debóra",pin: "1234"),
        User(name: "Ildikó",pin: "3561"),
        User(name: "Luca",pin: "3918"),
        User(name: "Márti",pin: "9128"),
        User(name: "Lucia",pin: "9183"),
        User(name: "Boglárka",pin: "2221"),
        User(name: "Réka",pin: "9191"),
        User(name: "Vanda",pin: "3192"),
        User(name: "Flóra",pin: "2322"),
    ]
}
