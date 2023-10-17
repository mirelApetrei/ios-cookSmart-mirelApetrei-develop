//
//  HomeView.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 31.08.23.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Variables

    @StateObject var ingredientVM =  IngredientViewModel()
    @StateObject var recipeVM = RecipeViewModel()
    @ObservedObject var homeViewModel = HomeViewModel()
    @State private var selectedMealType: String?
    @State private var searchQuery: String = ""

    @State private var showMealTypeSheet = false
    @State private var arrayWithIngredients: [String] = []
    @State private var ingredientText = ""
    @State private var navigateToSettings = false


    @State private var isButtonPressed = false

    var body: some View {

        ZStack {
            Image("background4")
                .resizable()
                .opacity(0.6)
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Need some ideas for dinner? ")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 6)

                // New TextField and Search Button
                HStack {
                    TextField("Search", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 280)
                        .cornerRadius(20)
                        .padding(8)

                    Button("Search") {
                        homeViewModel.query = searchQuery
                        homeViewModel.searchBy = .query
                        homeViewModel.startRecipesSearch()
                        searchQuery = ""
                    }
                    .padding(8)
                    .background(Color("primaryButtonColor"))
                    .foregroundColor(.white)
                    .cornerRadius(28)
                }

                // Meal type button
                SecondaryButton(title: " Meal Type") {
                    showMealTypeSheet = true
                }
                .padding(.bottom, 4)

                // IN THIS SECTION ARE SHOWN THE RANDOM RECIPES
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(homeViewModel.randomRecipes, id: \.self) { recipe in
                            NavigationLink(destination: DetailsView(recipe: recipe)) {
                                RecipeCardView(recipe: recipe)
                                    .padding(8)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)

                // SHEET FOR MEAL TYPES
                .sheet(isPresented: $showMealTypeSheet) {
                    // The sheet content here - MealTypeSheet
                    MealTypeSheet(selectedMealType: Binding.constant(homeViewModel.mealType ?? "desert"), homeViewModel: homeViewModel)
                        .presentationDetents([.medium, .large])
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .onAppear {
                    homeViewModel.fetchData()
                }
            }
        }
        .environmentObject(recipeVM)
        .navigationBarTitle("Home", displayMode: .inline) // Optional title for clarity
                   .navigationBarItems(trailing: HStack { // 2. Add TextButton to the navigation bar trailing side
                       TextButton(title: "Settings") {
                           navigateToSettings = true
                       }
                       NavigationLink("", destination: SettingsView(), isActive: $navigateToSettings) // 3. NavigationLink for navigating to SettingsView
                           .frame(width: 0, height: 0)
                           .hidden()
                   })
    }
}

    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView(ingredientVM: IngredientViewModel())

        }
    }
