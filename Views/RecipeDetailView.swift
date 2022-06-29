//
//  RecipeDetailView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-28.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            /* Recipe Author name */
            HStack {
                Text("Author: \(recipe.recipeInformation.authorName)")
                    .font(.subheadline)
                    .padding()
                   
                Spacer()
            }

            /* Recipe description name */
            HStack {
                Text("\(recipe.recipeInformation.description)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            
            /* Ingredients + Directions List */
            List {
                Section(
                    content: {
                        ForEach(recipe.ingredients.indices, id: \.self) { idx in
                            let ingredient: Ingredient = recipe.ingredients[idx]
                            Text(ingredient.description)
                                .foregroundColor(UIConstants.listRowFontColor)
                        }
                    },
                    header: {Text("Ingredients")}
                )
                .listRowBackground(UIConstants.mainColor)
                
                Section(
                    content: {
                        ForEach(recipe.directions.indices, id: \.self) { idx in
                            let direction: Direction = recipe.directions[idx]
                            HStack {
                                Text("\(idx + 1). ").bold()
                                // Display differently based on the optionality of the direction
                                if (direction.isOptional) {
                                    Text("OPTIONAL: \(direction.description)")
                                } else {
                                    Text(direction.description)
                                }
                            }
                            .listRowBackground(UIConstants.mainColor)
                            .foregroundColor(UIConstants.listRowFontColor)
                        }
                    },
                    header: {Text("Directions")}
                )
                
            }
            
        }
        .navigationTitle(recipe.recipeInformation.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var mockRecipe = Recipe.mockedRecipes[0]
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: mockRecipe)
        }
    }
}
