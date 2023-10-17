//
//  FavoritesCard.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 26.09.23.
//

import SwiftUI

struct RecipeResultCard: View {

    // MARK: - Variables
    var recipe: Recipe

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame( maxWidth: .infinity, maxHeight: 220)
                .shadow(radius: 4, y: 4)
                .padding(.horizontal, 6)


            HStack {
                // Async image loading
                if let imageUrl = URL(string: recipe.image ?? "") {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "fork.knife.circle")
                        Text("Loading...")
                    }
                    .frame(width: 160, height: 220)
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(8)
                } else {
                    Image(systemName: "fork.knife.circle")
                        .frame(width: 120, height: 100)
                }
                VStack {
                    Text(recipe.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.vertical, 4)


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
                        }

                    }
                }



                .padding()
            }

        }
    }
}

#Preview {
    RecipeResultCard(recipe: Recipe(id: 1, title: "Title", cheap: true, image: "image", aggregateLikes: 1, readyInMinutes: 1, isVegan: true, glutenFree: true, summary: "", instructions: "", spoonacularSourceUrl: "", extendedIngredients:[]))
}
