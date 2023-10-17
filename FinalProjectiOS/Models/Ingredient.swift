//
//  Ingredient.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 31.08.23.
//

import Foundation

struct Ingredient: Identifiable, Hashable, Codable {

    let id: Int
    let name: String
    let image: String // URL as String
    let unit: String
    let amount: Double
}

struct IngredientsResponse: Decodable {
    let ingredients: [Ingredient]
}
