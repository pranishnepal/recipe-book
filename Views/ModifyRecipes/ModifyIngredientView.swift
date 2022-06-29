//
//  ModifyIngredientView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-28.
//

import SwiftUI

struct ModifyIngredientView: View {
    @Binding var ingredient: Ingredient
    
    /* Closure to perform the modification of the ingredient */
    let performModification: ((Ingredient) -> Void)
    
    /* Dismiss view after saving */
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Ingredient name", text: $ingredient.name)
                .listRowBackground(UIConstants.mainColor)
            
            Stepper(
                value: $ingredient.quantity,
                in: 0...100,
                step: 0.5,
                label: {
                    HStack {
                        Text("Quantity")
                        TextField(
                            "Quantity",
                            value: $ingredient.quantity,
                            formatter: NumberFormatter.decimal
                        )
                        .keyboardType(.numbersAndPunctuation)
                    }
                }
            )
            .listRowBackground(UIConstants.mainColor)
            
            Picker(
                selection: $ingredient.unit,
                content: {
                    ForEach(Ingredient.IngredientUnit.allCases, id: \.self) { currUnit in
                        Text(currUnit.rawValue)
                    }
                },
                label: {
                    HStack {
                        Text("Unit")
                        Spacer()
                        
                    }
                }
            )
            .listRowBackground(UIConstants.mainColor)
            
            /* Button to save the ingredient */
            HStack {
                Spacer()
                Button("Save") {
                    performModification(ingredient)
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .listRowBackground(UIConstants.mainColor)
            
            
        }
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

struct ModifyIngredientView_Previews: PreviewProvider {
    @State static var recipe = Recipe.mockedRecipes[0]
    
    static var previews: some View {
        NavigationView {
            ModifyIngredientView( ingredient: $recipe.ingredients[0]) { ingredient in
                // print as the 'implementation' of the closure `performModification`
                print(ingredient)
            }.navigationTitle("Add ingredient")
        }
    }
}
