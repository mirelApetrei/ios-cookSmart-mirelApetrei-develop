//
//  HomeViewModel.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 31.08.23.
//

import Foundation

enum SearchBy {
    case mealType
    case query
}

// HomeViewModel.swift
class HomeViewModel: ObservableObject {
    
    @Published var randomRecipes: [Recipe] = []
    @Published var isFavourite = false

    var recipeRepo = RecipeRepository()
    var mealType: String?
    var query: String
    var searchBy: SearchBy

    init(searchBy: SearchBy = .mealType, mealType: String = "", query: String = "") {
        self.searchBy = searchBy
        self.mealType = mealType
        self.query = query
        fetchData()
        }


    func fetchData() {
        recipeRepo.fetchRandomRecipes { recipes in
            DispatchQueue.main.async {
                self.randomRecipes = recipes
            }
        }
    }

    func startRecipesSearch() {
        switch searchBy {
        case .mealType:
            print(" startRecipesSearch() -> byType - from HomeViewModel triggerd")
            recipeRepo.fetchRecipesByType(mealType: self.mealType ?? "") { recipes in
                DispatchQueue.main.async {
                    self.randomRecipes = recipes
                    print("after startRecipesSearch() -> byType - from HomeViewModel triggerd")
                }
            }
        case .query:
            print(" startRecipesSearch() -> byQuery - from HomeViewModel triggerd")
            recipeRepo.fetchRecipesByQuery(query: self.query) { recipes in
                DispatchQueue.main.async {
                    self.randomRecipes = recipes
                    print(" after startRecipesSearch() -> byQuery - from HomeViewModel triggerd")
                }
            }
        }
    }

    func setSelectedMealType(_ type: String?) {
        self.mealType = type ?? ""
        self.searchBy = .mealType
        startRecipesSearch()
        print("setSelectedMealType() - from HomeViewModel triggerd")
    }

}
