//
//  ModifyRecipeView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-28.
//

import SwiftUI

struct ModifyRecipeView: View {
    enum RecipeAspectSelection {
        case recipeInformation
        case directions
        case ingredients
    }
    
    @Binding var recipe: Recipe
    @State var recipeAspectSelected = RecipeAspectSelection.recipeInformation
    
    var body: some View {
        VStack {
            Picker(
                "Choose recipe's aspect",
                selection: $recipeAspectSelected,
                content: {
                    Text("Recipe Info").tag(RecipeAspectSelection.recipeInformation)
                    Text("Ingredients").tag(RecipeAspectSelection.ingredients)
                    Text("Directions").tag(RecipeAspectSelection.directions)
                }
            )
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            /* Based on the selection, render respective forms */
            switch recipeAspectSelected {
            case .recipeInformation:
                ModifyRecipeInformationView(
                    recipeInformation: $recipe.recipeInformation
                )
            case .directions:
                Text("Directions Editor")
            case .ingredients:
                ModifyIngredientsView(
                    ingredients: $recipe.ingredients
                )
            }
            
            Spacer()
        }
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe(
    )
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
