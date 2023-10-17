//
//  Recipe.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 31.08.23.
//

import Foundation
import FirebaseFirestoreSwift

struct Recipe: Identifiable, Codable, Hashable {

    let id: Int
    let title: String
    let cheap: Bool
    let image: String? // URL as String
    let aggregateLikes: Int
    let readyInMinutes: Int
    let isVegan: Bool?
    let glutenFree: Bool?
    let summary: String?
    let instructions: String?
    let spoonacularSourceUrl: String?
    let extendedIngredients: [Ingredient]?



    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encode(cheap, forKey: .cheap)
            try container.encode(image, forKey: .image)
            try container.encode(aggregateLikes, forKey: .aggregateLikes)
            try container.encode(readyInMinutes, forKey: .readyInMinutes)
            try container.encode(isVegan, forKey: .isVegan)
            try container.encode(glutenFree, forKey: .glutenFree)
            try container.encode(summary, forKey: .summary)
            try container.encode(instructions, forKey: .instructions)
            try container.encode(spoonacularSourceUrl, forKey: .spoonacularSourceUrl)
            try container.encode(extendedIngredients, forKey: .extendedIngredients)
        }
}
