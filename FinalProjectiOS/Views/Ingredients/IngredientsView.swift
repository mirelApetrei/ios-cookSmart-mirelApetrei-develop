//
//  IngredientsView.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 11.10.23.
//

import SwiftUI

struct IngredientsView: View {
    // MARK: - Variables
    @EnvironmentObject var recipeVM: RecipeViewModel
    @StateObject var ingredientsVM = IngredientViewModel()
    @State private var navigateToShoppingList = false
    @State var ingredients: [Ingredient]


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(ingredients, id: \.id) { ingredient in
                        IngredientCard(ingredient: ingredient, ingredientVM: ingredientsVM)
                    }
                }
            }
            .navigationTitle("INGREDIENTS: ")

            // MARK: Button for saving the ingredients from this recipe
            Button(action: {
                ingredientsVM.saveForShopping()
                navigateToShoppingList.toggle()
            }) {
                Text("Save ingredients for shopping")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color("primaryButtonColor"))
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
            .padding()
            NavigationLink(destination: ShoppingListView(), isActive: $navigateToShoppingList) {
                EmptyView()
            }
        }

    }
}

#Preview {
    IngredientsView(ingredients: [
        Ingredient(id: 1, name: "Sugar", image: "sugar.jpg", unit: "g", amount: 100.0),
        Ingredient(id: 2, name: "Flour", image: "flour.jpg", unit: "g", amount: 200.0),
        Ingredient(id: 3, name: "Milk", image: "milk.jpg", unit: "ml", amount: 150.0),
        Ingredient(id: 4, name: "Egg", image: "egg.jpg", unit: "pcs", amount: 2.0),
        Ingredient(id: 5, name: "Salt", image: "salt.jpg", unit: "g", amount: 5.0)])
}
