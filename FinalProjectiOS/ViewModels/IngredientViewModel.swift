//
//  IngredientViewModel.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 20.09.23.
//

import Foundation
import SwiftUI
import Combine

class IngredientViewModel: ObservableObject {

//    init(searchText: Binding<String>) {
//        self._searchText = searchText
//    }


    // MARK: - Functions

    // MARK: - saveForShopping()
    func saveForShopping() {
        print("saveForShopping() from Ingredient View Model method triggered.")

        ingredientRepository.saveForShopping(ingredients: chosenIngredients)
    }






    // MARK: - fetchIngredients()
    func fetchIngredients() {
        ingredientRepository.fetchIngredients { [weak self] ingredients in
            DispatchQueue.main.async {
                self?.chosenIngredients = ingredients
            }
        }
    }

    // MARK: - fetchIngredientsByName()
    func fetchIngredientsByName() {
        ingredientRepository.searchIngredientByName(query: "\(searchText)") { [weak self] ingredients in
            DispatchQueue.main.async {
                self?.chosenIngredients = ingredients
            }
        }
    }

    // MARK: - searchIngredientByName()
    func searchIngredientByName(query: String) {
        print("searchIngredientByName from Ingredient View Model method triggered.")

        ingredientRepository.searchIngredientByName(query: "\(searchText)") { [weak self] ingredients in
            DispatchQueue.main.async {
                self?.chosenIngredients = ingredients
            }
        }
    }

    // MARK: - deleteIngredient()
    func deleteIngredient(at offsets: IndexSet) {
        chosenIngredients.remove(atOffsets: offsets)
    }

    // MARK: - autocomplete()
    func autocomplete(text: String, arrayWithIngredients: Binding<[String]>) {
        let results = chosenIngredients.filter {
            $0.name.localizedCaseInsensitiveContains(text)
        }.map { $0.name }
        arrayWithIngredients.wrappedValue = results
    }


    // MARK: - updateArrayWithIngredients()
    func updateArrayWithIngredients(arrayWithIngredients: inout [String]) {
        let newNames = chosenIngredients.map { $0.name }
        arrayWithIngredients = newNames
    }


    // MARK: - Variables

    @Published var chosenIngredients: [Ingredient] = []
    private let ingredientRepository = IngredientsRepository()
    @Published var searchText: String = ""

}
