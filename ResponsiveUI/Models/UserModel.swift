//
//  User.swift
//  ResponsiveUI
//
//  Created by Rendi Wijiatmoko on 19/04/22.
//

import SwiftUI

// MARK: User Model and Sample Data

struct User: Identifiable {
    var id = UUID().uuidString
    var name: String
    var image: String
    var title: String
}

var users: [User] = [
    User(name: "Momo", image: "User1", title: "New Oportunity"),
    User(name: "Rendi", image: "User2", title: "Welcome to the family"),
    User(name: "Momo", image: "User1", title: "New Design"),
]
