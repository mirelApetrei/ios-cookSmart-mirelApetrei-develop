//
//  IngredientCard.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 19.09.23.
//

import SwiftUI

struct IngredientCard: View {

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
                .frame( maxWidth: .infinity, maxHeight: 85)
                .shadow(radius: 4, y: 4)
            HStack {
                HStack {
                    // Ingredient image
                    if let imageUrl = URL(string: ingredient.image ) {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            Image(systemName: "photo")
                        }
                        .frame(width: 80, height: 85)
                        .scaledToFit()
                        .clipped()

                    } else {
                        Image(systemName: "photo")
                            .frame(width: 80, height: 80)
                    }

                    // Ingredient name
                    Text(ingredient.name )
                        .font(.headline)
                        .fontWeight(.regular)
                }

                HStack {
                    Text(String(format: "Qty: %.2f", ingredient.amount))
                        .font(.subheadline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    Text(ingredient.unit ?? "")
                        .font(.subheadline)
                        .fontWeight(.light)
                }
                .padding()
            }
        }
        .padding(.horizontal, 8)
        .shadow(radius: 4, y: 4)
    }
    
    // MARK: - Variables
    var ingredient: Ingredient
    var ingredientVM: IngredientViewModel

}


#Preview {
    IngredientCard(ingredient: Ingredient(id: 12, name: "etwas", image: "cucumber", unit: "tbsp", amount: 1.5), ingredientVM: IngredientViewModel())
}
