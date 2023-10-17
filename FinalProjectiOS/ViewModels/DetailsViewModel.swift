//
//  DetailsViewModel.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 13.09.23.
//

import Foundation

class DetailsViewModel: ObservableObject {

    init(recipeDetail: RecipeDetailModel) {
            self.recipeDetail = recipeDetail
        }

    // MARK: - Variables

    let recipeRepository = RecipeRepository()
    @Published var recipeDetail: RecipeDetailModel
    @Published var isFavorite = false

    // MARK: - Functions

    
    
}
