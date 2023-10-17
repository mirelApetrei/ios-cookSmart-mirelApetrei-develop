//
//  DetailsView.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 20.09.23.
//

import SwiftUI

struct DetailsView: View {

    // MARK: - Variables
    let recipe: Recipe
    @State private var showFavorites = false

    @ObservedObject var recipeVM = RecipeViewModel()
    @ObservedObject var userVM = UserViewModel()

    @State private var isFavourite = false


    var body: some View {

        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(width: 400, height: 340)
                .shadow(radius: 6, y: 6)
                .padding(.bottom, 8)

            // Async image loading
            if let urlString = recipe.image, let imageUrl = URL(string: urlString) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                }  placeholder: {
                    Image(systemName: "fork.knife.circle")
                    Text("Loading...")
                }
                .frame(width: 400, height: 300)
                .scaledToFill()
                .clipped()
                .cornerRadius(8)
            } else {
                Image(systemName: "fork.knife.circle")
                    .frame(width: 160, height: 180)
            }
        }
        .ignoresSafeArea( edges: .top)

        HStack {
            Spacer(minLength: 150)

            TextButton(title: "Go to Favorites", action: {
                self.showFavorites = true
            })

            NavigationLink("", destination: FavoritesView(), isActive: $showFavorites)
                .frame(width: 0, height: 0)
                .hidden()

        }


        VStack {
            HStack {
                VStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(recipe.aggregateLikes)")
                }
                .padding(.trailing, 8)

                VStack {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.green)
                    Text(recipe.isVegan == true ? "Yes" : "No")
                }
                .padding(.trailing, 8)

                VStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.orange)
                    Text("\(recipe.readyInMinutes)")
                }
                Spacer()
                // CLICKABLE STAR - FAVOURITE
                Image(systemName: isFavourite ? "star.fill" : "star")
                    .foregroundColor(isFavourite ? .yellow : .gray)
                    .fontWeight(.heavy)
                    .onTapGesture {
                        isFavourite.toggle()
                        if self.isFavourite {
                            if let userId = userVM.userId, !userId.isEmpty {
                                recipeVM.addToFavourites(recipe: recipe, userId: userId) {}
                                recipeVM.fetchFavoriteRecipes(forUserID: userId)
                            } else {
                                print("UserID is empty or nil")
                            }
                        } else {
                            recipeVM.removeFromFavourites(recipe: recipe) {}
                        }
                    }
            }
            .padding(.horizontal, 10)

            // New buttons added here
            HStack {
                Link(destination: URL(string: recipe.spoonacularSourceUrl ?? "") ?? URL(string: "https://google.com")!) {
                    Text("Website")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }

                Spacer()

                NavigationLink(destination: IngredientsView(ingredients: recipe.extendedIngredients ?? [])) {
                    Text("Ingredients")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }

            }
            .padding(12)

            ScrollView {
                VStack(alignment: .leading) {
                    Text(recipe.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)

                    VStack(alignment: .leading) {
                        Text("Summary: ")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top, 6)

                        Text(recipe.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 8)
                        Text("Instructions: ")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top, 8)
                        Text(recipe.instructions?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 8)
                    }
                }
            }
        }
    }
}



    #Preview {
        DetailsView(recipe: Recipe(id: 1, title: "Some dummy title for my preview", cheap: true, image: "image", aggregateLikes: 1, readyInMinutes: 1, isVegan: true, glutenFree: true, summary: "Quick and easy chicken stir-fry: Marinate chicken in soy sauce and garlic. Sauté veggies. Cook chicken. Combine and season. Serve over rice. Ready in 30 minutes. Serves 4.", instructions: "Place the champagne in a large skillet and bring to a boil over high heat. Add the salt, scallions, and sea bass and return to a boil. Reduce heat to low, cover, and simmer 5 minutes. Add the cucumbers and cook 3 to 5 minutes more or until the fish just flakes when tested with a fork. Remove the fish and vegetables from the skillet and keep warm. Increase heat to high and boil the liquid in the skillet, uncovered, until reduced to 1/2 cup, about 5 minutes. Blend in the light cream. Spoon some sauce onto each of 4 plates. Arrange the vegetables and fish on top.", spoonacularSourceUrl: """
                           https://spoonacular.com/pasta-with-garlic-scallions-cauliflower-breadcrumbs-716429
                           """, extendedIngredients: [Ingredient(id: 1, name: "Ingredient", image: "image", unit: "unit", amount: 2.0)]))
    }

