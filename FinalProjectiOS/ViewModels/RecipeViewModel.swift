//
//  RecipeViewModel.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 06.09.23.
//
import Foundation


class RecipeViewModel: ObservableObject {

    func fetchData() {
        recipeRepository.fetchRandomRecipes { [weak self] recipes in
            DispatchQueue.main.async {
                self?.randomRecipes = recipes
            }
        }
    }

    func addToFavourites(recipe: Recipe, userId: String, completion: @escaping () -> Void) {
        recipeRepository.addToFavourites(recipe: recipe, forUserID: userId) {
            DispatchQueue.main.async {
                completion()
                print("Added to favourites - RecipeViewModel")
            }
        }
    }

      func removeFromFavourites(recipe: Recipe, completion: @escaping () -> Void) {
          recipeRepository.removeFromFavourites(recipe: recipe) {
              DispatchQueue.main.async {
                  completion()
                  print("Removed from favourites - RecipeViewModel")
              }
          }
      }

    func fetchFavoriteRecipes(forUserID userID: String) {
        recipeRepository.fetchFavorites(for: userID) { [weak self] recipes in
            DispatchQueue.main.async {
                self?.favoriteRecipes = recipes
            }
        }
    }



// MARK: - Variables

    @Published var favoriteRecipes: [Recipe] = []

    @Published var randomRecipes: [Recipe] = []
    private let recipeRepository = RecipeRepository()

    @Published var user: User?

}
