//
//  RecipeCard.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 06.09.23.
//

import SwiftUI

struct RecipeCardView: View {
    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("cardColor"))
                .frame( maxWidth: .infinity, maxHeight: 180)
                .shadow(radius: 4, y: 4)
                .padding(.horizontal, 12)
            
            HStack {
                // Async image loading
                if let imageUrl = URL(string: recipe.image ?? "") {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "fork.knife.circle")
                        Text("Loading...")
                    }
                    .frame(width: 180, height: 180)
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(8)
                } else {
                    Image(systemName: "fork.knife.circle")
                        .frame(width: 180, height: 180)
                }
                VStack {
                    Text(recipe.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.vertical, 16)

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
                .padding(8)
            }
        }
    }

    // MARK: - Variables
    var recipe: Recipe
}

#Preview {
    RecipeResultCard(recipe: Recipe(id: 1, title: "Titlesome more titliesdasdadasdasdasd sdasda", cheap: true, image: "image", aggregateLikes: 1, readyInMinutes: 1, isVegan: true, glutenFree: true, summary: "", instructions: "", spoonacularSourceUrl: "", extendedIngredients: []))
}
