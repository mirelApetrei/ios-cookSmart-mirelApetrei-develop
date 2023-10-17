//
//  User.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 04.09.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift



struct User: Codable, Identifiable {

    @DocumentID var id: String?
    var email: String
    var password: String
    var likedRecipes: [Recipe]?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case password
        case likedRecipes
    }


    init(id: String? = "", email: String, password: String, likedRecipes: [Recipe]) {
        self.id = id
        self.email = email
        self.password = password
        self.likedRecipes = likedRecipes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        likedRecipes = try container.decode([Recipe].self, forKey: .likedRecipes)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(likedRecipes, forKey: .likedRecipes)
    }
}
