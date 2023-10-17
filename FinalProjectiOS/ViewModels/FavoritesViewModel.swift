//
//  FavoritesViewModel.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 11.10.23.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favoriteRecipes: [Recipe] = []

    func removeRecipe(at offsets: IndexSet, recipeViewModel: RecipeViewModel) {
        offsets.forEach { index in
            let recipe = favoriteRecipes[index]
            recipeViewModel.removeFromFavourites(recipe: recipe) {
                DispatchQueue.main.async {
                    // Remove the recipe from favoriteRecipes
                    self.favoriteRecipes.remove(at: index)
                }
            }
        }
    }
}
