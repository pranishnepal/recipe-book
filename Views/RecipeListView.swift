//
//  RecipeListView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-27.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    let category: RecipeInformation.Category
    
    @State var isPresentingSheet: Bool = false
    @State var newRecipe: Recipe = Recipe()
    
    private let listRowBackgroundColor = UIConstants.mainColor
    
    var body: some View {
        /* List of recipes for category `category` using `recipe` computed prop */
        List {
            ForEach(recipesForASpecificCategory) { recipe in
                NavigationLink(
                    destination: {
                        RecipeDetailView(recipe: recipe)
                    },
                    label: {
                        Text(recipe.recipeInformation.name)
                    }
                )
            }
            .listRowBackground(UIConstants.mainColor)
            .foregroundColor(UIConstants.listRowFontColor)
        }
        .navigationTitle(navigationTitle)
        
        /* Toolbar to add new recipe */
        .toolbar(
            content: {
                ToolbarItem(
                    placement: .navigationBarTrailing,
                    content: {
                        Button(
                            action: {
                                /* Add new recipe to this category */
                                isPresentingSheet = true
                                newRecipe = Recipe()
                                
                                newRecipe.recipeInformation.category = recipesForASpecificCategory[0].recipeInformation.category
                                
                                /* TODO: REMOVE THE FOLLOWING TEST DATA WHEN DONE
                                    newRecipe.directions =  [
                                        Direction(description: "sdf", isOptional: false)
                                    ]
                                    
                                    newRecipe.ingredients = [
                                        Ingredient(name: "OK", unit: .cups, quantity: 1.9)
                                    ]
                                */
                            },
                            label: {
                                Image(systemName: "plus")
                            }
                        )
                    }
                )
            }
        )
        
        /* Implement Sheet view; displayed when `isPresentingSheet` is True */
        .sheet(
            isPresented: $isPresentingSheet,
            content: {
                NavigationView {
                    ModifyRecipeView(recipe: $newRecipe)
                        .toolbar(
                            content: {
                                /* Button to dismiss the sheet */
                                ToolbarItem(
                                    placement: .cancellationAction,
                                    content: {
                                        Button("Dismiss") {
                                            isPresentingSheet = false
                                        }
                                    }
                                )
                                
                                /* Button to add a new recipe */
                                ToolbarItem(
                                    placement: .confirmationAction,
                                    content: {
                                        Button(
                                            action: {
                                                if newRecipe.isValid {
                                                    recipeViewModel.addNewRecipe(recipe: newRecipe)
                                                    isPresentingSheet = false
                                                }
                                            },
                                            label: {
                                                Text("Add")
                                            }
                                        )
                                    }
                                )
                            }
                        )
                        .navigationTitle("Add a new recipe")
                }
                
            }
        )
        
    }
}

extension RecipeListView {
    var navigationTitle: String {
        "Recipes for \(category.rawValue)"
    }
    
    var recipesForASpecificCategory: [Recipe] {
        recipeViewModel.getRecipesForACategory(category: category)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var category = RecipeInformation.Category.dinner
    static var previews: some View {
        NavigationView {
            RecipeListView(category: category)
                .environmentObject(RecipeViewModel())
        }
    }
}
