//
//  IngredientsRepository.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 19.09.23.
//

import Foundation


class IngredientsRepository {

    func fetchIngredients(completion: @escaping ([Ingredient]) -> Void) {
        let urlString = ingredientsURL
        guard let url = URL(string: urlString) else {
            print("error on URL")
            completion([]) // Return empty array on URL error
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error  in
            if let data = data, error == nil {
                let decoder = JSONDecoder()

                do {
                    let ingredientResponse = try decoder.decode(IngredientsResponse.self, from: data)
                    completion(ingredientResponse.ingredients)
                } catch {
                    print("Decoding error: \(error)")
                    completion([])
                }
            } else {
                completion([])
                print("Error fetching data, \(String(describing: error))")


            }
        }.resume()
    }

    // MARK: Search Ingredient by Name
    func searchIngredientByName(query: String, completion: @escaping ([Ingredient]) -> Void) {
        print("searchIngredientByName from Repository triggered.")

        let baseURL = "https://api.spoonacular.com/food/ingredients/autocomplete?query=\(query)&apiKey=\(apiKey)"
        let queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "number", value: "5"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]

        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            completion([])
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion([])
                return
            }


            do {
                let decoder = JSONDecoder()
                let ingredientResponse = try decoder.decode([Ingredient].self, from: data)
                print("IngredientResponse: \(ingredientResponse)")

//                if let firstResponse = ingredientResponse.first {
//                    completion(firstResponse.ingredients)
//                } else {
//                    completion([])
//                }
            } catch {
                completion([])
            }

        }
        task.resume()
    }


//    MARK: saveForShopping()
    func saveForShopping(ingredients: [Ingredient]) {
        let newList = ShoppingListView()

    }
        // MARK: - Variables
    let apiKey = Api.key

    let ingredientsURL = Api.randomBaseUrl

    }
