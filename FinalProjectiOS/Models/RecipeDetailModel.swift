//
//  RecipeDetailResponse.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 13.09.23.
//

import Foundation

struct RecipeDetailModel: Codable, Identifiable {
    var id: Int
    var title: String
    var image: String?
    var instructions: String?
    var extendedIngredients: [Ingredient]

    enum CodingKeys: String, CodingKey {
        case id, title, image, instructions
        case extendedIngredients 
    }
}
