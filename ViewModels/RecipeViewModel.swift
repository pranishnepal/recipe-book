//
//  RecipeViewModel.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-27.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes =  Recipe.mockedRecipes
    
    func addNewRecipe(recipe: Recipe) -> Void {
        if (recipe.isValid) {
            recipes.append(recipe)
        }
    }
    
    func getRecipesForACategory(category: RecipeInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        
        for recipe in recipes {
            if recipe.recipeInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        
        return filteredRecipes
    }
}
