//
//  ShoppingList.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 12.10.23.
//

import SwiftUI

struct ShoppingList: Identifiable {
    var id = UUID()
    var items: [Ingredient]
}


struct ShoppingListView: View {
    @State var shoppingLists: [ShoppingList] = []

    var dummyIngredients: [Ingredient] = [
            Ingredient(id: 1, name: "Sugar", image: "sugar.jpg", unit: "g", amount: 100.0),
            Ingredient(id: 2, name: "Flour", image: "flour.jpg", unit: "g", amount: 200.0),
            Ingredient(id: 3, name: "Milk", image: "milk.jpg", unit: "ml", amount: 150.0),
            Ingredient(id: 4, name: "Egg", image: "egg.jpg", unit: "pcs", amount: 2.0),
            Ingredient(id: 5, name: "Salt", image: "salt.jpg", unit: "g", amount: 5.0),
            Ingredient(id: 6, name: "Oil", image: "oil.jpg", unit: "ml", amount: 50.0),
            Ingredient(id: 7, name: "Bread", image: "bread.jpg", unit: "slice", amount: 4.0)
        ]

        var body: some View {
            List {
                ForEach(1...6, id: \.self) { index in
                    Section(header: Text("List \(index)")) {
                        ForEach(dummyIngredients, id: \.id) { ingredient in
                            Text("\(ingredient.name): \(ingredient.amount) \(ingredient.unit)")
                        }
                    }
                }
            }
        }

    // MARK: - Functions

    func deleteList(at offsets: IndexSet) {
            shoppingLists.remove(atOffsets: offsets)
        }
}

#Preview {
    ShoppingListView()
}
