//
//  RecipeViewModel.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-27.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes =  Recipe.mockedRecipes
    
    private var recipesFileURL: URL {
        do {
            let documentsDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            return documentsDirectory.appendingPathExtension("recipeData")
        } catch {
            fatalError("Could not retrieve the file url: \(error)")
        }
    }
    
    func saveRecipes() {
        do {
            let encodedData = try JSONEncoder().encode(recipes)
            try encodedData.write(to: recipesFileURL)
        } catch {
            fatalError("Could not save recipes \(error)")
        }
    }
    
    func loadRecipes() {
        guard let retrievedData = try? Data(contentsOf: recipesFileURL) else { return }
        do {
            let savedRecipes = try JSONDecoder().decode([Recipe].self, from: retrievedData)
            
            recipes = savedRecipes
        } catch {
            fatalError("Could not load recipes \(error)")
        }
    }
    
    func addNewRecipe(recipe: Recipe) -> Void {
        if (recipe.isValid) {
            recipes.append(recipe)
            saveRecipes()
        }
    }
    
    func getIndexOfRecipe(recipe: Recipe) -> Int? {
        for currIdx in recipes.indices {
            if recipe.id == recipes[currIdx].id {
                return currIdx
            }
        }
        
        return nil
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
