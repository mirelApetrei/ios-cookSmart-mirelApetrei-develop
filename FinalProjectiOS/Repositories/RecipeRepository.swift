//
//  RecipeRepository.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 31.08.23.
//

import Foundation
import Firebase
import Combine


class RecipeRepository {

    // MARK: - Fetch random recipes
    func fetchRandomRecipes(completion: @escaping ([Recipe]) -> Void) {
        print("fetchRandomRecipes() from repository")
        let urlString = randomURLSearch // Fetches 10 random recipes
        guard let url = URL(string: urlString) else {
            completion([]) // Return empty array on URL error
            print("after first completion(), keine url gefundet.")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error  in
            if let data = data, error == nil {
                let decoder = JSONDecoder()
                do {
                    let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                    print("after first completion(), keine url gefundet.")
                    completion(recipeResponse.recipes)

                } catch {
                    print("Decoding error: \(error)")
                    completion([])
                }
            } else {
                completion([])
            }
        }.resume()
    }


    // MARK: fetchRecipesByType()
    func fetchRecipesByType(mealType: String, completion: @escaping ([Recipe]) -> Void) {
        print("fetchRecipesByType() from repository")
        let urlString = BASE_URL + "&type=\(mealType)"
        guard let url = URL(string: urlString) else {
            completion([]) // Return empty array on URL error
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error  in
            if let data = data, error == nil {
                let decoder = JSONDecoder()
                do {
                    let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                    completion(recipeResponse.recipes)

                } catch {
                    print("Decoding error: \(error)")
                    completion([])
                }
            } else {
                completion([])
            }
        }.resume()
    }

    // MARK: fetchRecipesByQuery()
    func fetchRecipesByQuery(query: String, completion: @escaping ([Recipe]) -> Void) {
        print("fetchRecipesByQuery() from repository")
        let urlString = BASE_URL + "&query=\(query)"
        guard let url = URL(string: urlString) else {
            completion([]) // Return empty array on URL error
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error  in
            if let data = data, error == nil {
                let decoder = JSONDecoder()
                do {
                    let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                    completion(recipeResponse.recipes)

                } catch {
                    print("Decoding error: \(error)")
                    completion([])
                }
            } else {
                completion([])
            }
        }.resume()
    }

    // MARK: ADD TO FAVORITES
    func addToFavourites(recipe: Recipe, forUserID userID: String, completion: @escaping () -> Void) {
        print("🥊🥊🥶Attempting to add to favorites...🥶🥊🥊")
            do {
                let recipeData = try JSONEncoder().encode(recipe)
                let recipeJSON = try JSONSerialization.jsonObject(with: recipeData, options: [])

                let firestoreDB = Firestore.firestore()
                let recipeRef = firestoreDB.collection("users").document(userID).collection("favourites").document()
                recipeRef.setData(recipeJSON as? [String: Any] ?? [:]) { error in
                    if let error = error {
                        print("Error saving recipe: \(error)")
                    } else {
                        print("Recipe saved successfully")
                    }
                }
            } catch {
                print("Error encoding recipe: \(error)")
            }
        }

    // MARK: REMOVE FROM FAVOURITES
    func removeFromFavourites(recipe: Recipe, completion: @escaping () -> Void) {
        let firestoreDB = Firestore.firestore()

        let query = firestoreDB.collection("favourites").whereField("id", isEqualTo: recipe.id)
        query.getDocuments { snapshot, error in
            if let error = error {
                // Handle the error
                print("Error retrieving documents: \(error)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }

            for document in documents {
                document.reference.delete { error in
                    if let error = error {
                        // Handle the error
                        print("Error deleting document: \(error)")
                    } else {
                        completion()
                    }
                }
            }
        }
    }

    // MARK: - fetchFavorites()
    func fetchFavorites(for userID: String, completion: @escaping ([Recipe]) -> Void) {
        print("🥊🥊🥶Attempting to fetch from firestore to favorites...🥶🥊🥊")
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("users").document(userID).collection("favourites").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                completion([])
                return
            }

            var recipes: [Recipe] = []
            let decoder = JSONDecoder()

            for document in documents {
                do {
                    // Convert Firestore document data to JSON data
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                    // Decode the JSON data to a Recipe object
                    let recipe = try decoder.decode(Recipe.self, from: jsonData)
                    recipes.append(recipe)
                } catch {
                    print("Decoding error: \(error)")
                }
            }
            completion(recipes)
        }
    }


    // MARK: - Variables

    let apiKey = Api.key
    let randomURLSearch = Api.randomBaseUrl
    let BASE_URL = Api.BASE_URL

}
