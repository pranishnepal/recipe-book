//
//  ModifyRecipeInformationView.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-28.
//

import SwiftUI

struct ModifyRecipeInformationView: View {
    @Binding var recipeInformation: RecipeInformation
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $recipeInformation.name)
                .listRowBackground(UIConstants.mainColor)
            
            TextField("Author Name", text: $recipeInformation.authorName)
                .listRowBackground(UIConstants.mainColor)
            
            Section(
                content: {
                    TextEditor(text: $recipeInformation.description)
                        .listRowBackground(UIConstants.mainColor)
                },
                header: {
                    Text("Description")
                        .foregroundColor(.black)
                }
            )
            
            Picker(
                selection: $recipeInformation.category,
                content: {
                    ForEach(RecipeInformation.Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }
                },
                label: {
                    HStack {
                        Text("Category")
                        Spacer()
                    }
                }
            )
            .listRowBackground(UIConstants.mainColor)
        }
        
    }
}

struct ModifyRecipeInformationView_Previews: PreviewProvider {
    @State static var recipeInformation = RecipeInformation(
        name: "Some recipe",
        authorName: "John doe",
        description: "Test",
        category: RecipeInformation.Category.dinner
    )
    
    @State static var emptyRecipeInfo = RecipeInformation(
        name: "",
        authorName: "",
        description: "",
        category: RecipeInformation.Category.breakfast
    )
    
    static var previews: some View {
        NavigationView {
            ModifyRecipeInformationView(recipeInformation: $emptyRecipeInfo)
            ModifyRecipeInformationView(recipeInformation: $recipeInformation)
        }
    }
}
