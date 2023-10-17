//
//  FavoritesView.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 26.09.23.
//

import SwiftUI

struct FavoritesView: View {

    @StateObject var recipeViewModel = RecipeViewModel()
    @StateObject var viewModel = FavoritesViewModel()

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.favoriteRecipes, id: \.id) { recipe in
                RecipeCardView(recipe: recipe)

            }
            .onDelete(perform: { indexSet in
                viewModel.removeRecipe(at: indexSet, recipeViewModel: recipeViewModel)
            })
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoritesView()
}
