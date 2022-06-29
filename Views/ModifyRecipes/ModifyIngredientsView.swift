//
//  ModifyIngredientsView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-28.
//

import SwiftUI

struct ModifyIngredientsView: View {
    @State var newIngredient = Ingredient()
    @Binding var ingredients: [Ingredient]
    
    var body: some View {
        VStack {
            let addNewIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                ingredients.append(ingredient)
                newIngredient = Ingredient()
            }.navigationTitle("Add ingredient")
            
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient", destination: addNewIngredientView)
                Spacer()
            } else {
                HStack {
                    Text("Ingredients")
                        .font(.title)
                        .padding()
                    Spacer()
                }
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                    }
                    .listRowBackground(UIConstants.mainColor)
                    NavigationLink(
                        "Add another Ingredient",
                        destination: addNewIngredientView
                    )
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(UIConstants.mainColor)
                    .foregroundColor(UIConstants.listRowFontColor)
                }
            }
            
        }
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var ingredients = Recipe.mockedRecipes[0].ingredients
    @State static var emptyIngredients: [Ingredient] = []
    
    static var previews: some View {
        NavigationView {
            ModifyIngredientsView(ingredients: $ingredients)
        }
        
        NavigationView {
            ModifyIngredientsView(ingredients: $emptyIngredients)
        }
    }
}
