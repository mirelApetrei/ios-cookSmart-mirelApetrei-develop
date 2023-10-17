//
//  MealType.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 10.10.23.
//

import SwiftUI

struct MealTypeSheet: View {

    let mealTypes = ["main course", "side dish", "dessert", "appetizer", "salad", "bread", "breakfast", "soup", "beverage", "sauce", "marinade", "fingerfood", "snack", "drink"]

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ForEach(0..<2) { rowIndex in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(mealTypes.chunked(into: mealTypes.count / 2)[rowIndex], id: \.self) { type in
                                Button(action: {
                                    selectedType = selectedType == type ? nil : type
                                    selectedMealType = selectedType ?? ""
                                    homeViewModel.setSelectedMealType(selectedType)
                                }) {
                                    Text(type)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(selectedType == type ? Color("mealTypeButtonColor") : Color.gray)
                                        .clipShape(RoundedRectangle(cornerRadius: 50))
                                }
                            }
                        }
                    }
                }
            }
            .frame(height: geometry.size.height / 2)
        }
        .navigationBarTitle("Meal types")
    }

    // MARK: - Variables
    @State private var selectedType: String?
    @Binding var selectedMealType: String
    var homeViewModel: HomeViewModel
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}


#Preview {
    MealTypeSheet(selectedMealType: .constant("desert"), homeViewModel: HomeViewModel())

}
